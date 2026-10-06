#!/usr/bin/env python3
"""Generate additive adapters from the canonical policy; preview by default."""
import argparse, hashlib, json, os, pathlib, re, shutil, tempfile, tomllib

START = '<!-- shared-authorization-policy:start -->'
END = '<!-- shared-authorization-policy:end -->'
TSTART = '# shared-authorization-policy:start'
TEND = '# shared-authorization-policy:end'
JSTART = '// shared-authorization-policy:start'
JEND = '// shared-authorization-policy:end'

def remove_block(text, start, end):
    if start not in text and end not in text: return text
    if text.count(start)!=1 or text.count(end)!=1 or text.index(start)>=text.index(end):
        raise ValueError('malformed shared policy markers')
    a=text.index(start); b=text.index(end)+len(end)
    if start==JSTART and text[b:b+1]=='\n': b+=1
    if a and text[a-1]=='\n': a-=1
    return text[:a]+text[b:]

def managed(text, start, end, body):
    block=start+'\n'+body.rstrip()+'\n'+end
    if start in text or end in text:
        remove_block(text,start,end)  # Validate before replacement.
        return re.sub(re.escape(start)+r'.*?'+re.escape(end),lambda _:block,text,flags=re.S)
    return text.rstrip()+'\n\n'+block+'\n'

def object_start(text):
    # Skip JSONC leading comments rather than selecting a brace inside one.
    i=0
    while i<len(text):
        if text[i].isspace() or text[i]=='\ufeff': i+=1
        elif text.startswith('//',i):
            j=text.find('\n',i); i=len(text) if j<0 else j+1
        elif text.startswith('/*',i):
            j=text.find('*/',i+2)
            if j<0: raise ValueError('unterminated JSONC comment')
            i=j+2
        else:
            if text[i]!='{': raise ValueError('JSONC object expected')
            return i
    raise ValueError('JSONC object expected')

def atomic_write(path,text,expected):
    path.parent.mkdir(parents=True,exist_ok=True)
    fd,tmp=tempfile.mkstemp(prefix=path.name+'.policy-',dir=path.parent)
    try:
        with os.fdopen(fd,'w',encoding='utf-8',newline='') as f:
            f.write(text); f.flush(); os.fsync(f.fileno())
        if path.exists(): shutil.copymode(path,tmp)
        current=path.read_text(encoding='utf-8') if path.exists() else None
        if current!=expected: raise ValueError(str(path)+': concurrent edit before replacement')
        os.replace(tmp,path)
    finally:
        if os.path.exists(tmp): os.unlink(tmp)

def main():
    p=argparse.ArgumentParser(); p.add_argument('--home',type=pathlib.Path,default=pathlib.Path.home()); p.add_argument('--apply',action='store_true'); args=p.parse_args()
    home=args.home.resolve(); policy=home/'.agents/authorization-policy.md'; content=policy.read_text(encoding='utf-8'); digest=hashlib.sha256(content.encode()).hexdigest()
    statepath=home/'.agents/authorization-adapter-state.json'
    state=json.loads(statepath.read_text(encoding='utf-8')) if statepath.exists() else {}; nextstate={}; planned={}
    def put(path,text):
        path=path.resolve(); old=path.read_text(encoding='utf-8') if path.exists() else None
        if path in planned and planned[path][1]!=text: raise ValueError('conflicting symlink targets')
        if old!=text: planned[path]=(old,text)
    def instruction(path,body):
        old=path.read_text(encoding='utf-8') if path.exists() else ''
        put(path,managed(old,START,END,body))
    for name in ('.codex','.codex-work'):
        root=home/name; path=root/'config.toml'
        if not path.exists(): continue
        old=path.read_text(encoding='utf-8'); stripped=remove_block(old,TSTART,TEND)
        if 'auto_review' in tomllib.loads(stripped):
            raise ValueError(str(path)+': reconcile unmanaged auto_review first')
        block='[auto_review]\nextra_policy = '+json.dumps(content,ensure_ascii=False)
        generated=managed(old,TSTART,TEND,block)
        tomllib.loads(generated)
        put(path,generated)
        instruction(root/'AGENTS.md','Read '+policy.as_posix()+' before provider delegation or remote writes; apply it alongside project gates.')
    allow=content.split('## Authorized company GLM review\n\n',1)[1].split('\n## Payload',1)[0].strip()
    for name in ('.claude','.claude-personal'):
        root=home/name
        if not root.exists(): continue
        path=root/'settings.json'; d=json.loads(path.read_text(encoding='utf-8')) if path.exists() else {}; auto=d.setdefault('autoMode',{})
        saved=state.get(str(path.resolve()),{}); generated={}
        for key,entry in [('environment','[shared-authorization-policy] '+content),('allow','[shared-authorization-policy] '+allow)]:
            values=auto.get(key,['$defaults'])
            if not isinstance(values,list) or any(not isinstance(v,str) for v in values): raise ValueError('autoMode string list expected')
            if '$defaults' not in values: raise ValueError(str(path)+': reconcile custom '+key+' without $defaults first')
            previous=saved.get(key)
            if previous is not None: values=[v for v in values if v!=previous]
            if any(v.startswith('[shared-authorization-policy]') and v!=entry for v in values): raise ValueError('untracked generated Claude entry')
            if entry not in values: values.append(entry)
            auto[key]=values; generated[key]=entry
        nextstate[str(path.resolve())]=generated
        put(path,json.dumps(d,indent=2,ensure_ascii=False)+'\n')
        instruction(root/'CLAUDE.md','@'+policy.as_posix())
    oc=home/'.config/opencode'
    if oc.exists():
        path=oc/'opencode.jsonc' if (oc/'opencode.jsonc').exists() else oc/'opencode.json'
        old=path.read_text(encoding='utf-8') if path.exists() else '{}\n'; clean=remove_block(old,JSTART,JEND)
        urls=('https://openrouter.ai/api/*','https://api.fireworks.ai/inference/*')
        if path.suffix=='.jsonc':
            basefile=oc/'opencode.json'
            base=json.loads(basefile.read_text(encoding='utf-8')) if basefile.exists() else {}
            if 'permission' in base or 'permissions' in base: raise ValueError('reconcile earlier JSON permission layer before generating JSONC permissions')
            if re.search(r'"(?:instructions|permission|permissions)"\s*:',clean): raise ValueError(str(path)+': reconcile existing JSONC instructions/permission first')
            pos=object_start(clean)
            fragment=json.dumps({'instructions':[policy.as_posix()],'permission':{'webfetch':dict.fromkeys(urls,'ask')}},indent=2)[1:-1].strip()
            # Preserve exactly the whitespace outside our block.
            insertion='\n'+JSTART+'\n'+fragment+',\n'+JEND+'\n'
            put(path,clean[:pos+1]+insertion+clean[pos+1:])
        else:
            d=json.loads(old); existing=d.setdefault('instructions',[])
            if policy.as_posix() not in existing: existing.append(policy.as_posix())
            perm=d.setdefault('permission',{}); web=perm.setdefault('webfetch',{})
            if not isinstance(web,dict): raise ValueError('reconcile scalar webfetch permission first')
            for url in urls: web.setdefault(url,'ask')  # Preserve existing deny/ask/allow.
            put(path,json.dumps(d,indent=2,ensure_ascii=False)+'\n')
    put(statepath,json.dumps(nextstate,indent=2,ensure_ascii=False)+'\n')
    print(json.dumps({'policy_sha256':digest,'apply':args.apply,'changed_paths':[str(x) for x in planned]}))
    if args.apply:
        # Reject concurrent edits before writing any file. Each replacement is atomic;
        # the multi-file update is not a transaction. Rerun to finish interrupted installs.
        for path,(old,new) in planned.items():
            current=path.read_text(encoding='utf-8') if path.exists() else None
            if current!=old: raise ValueError(str(path)+': changed since preview')
        for path,(old,new) in planned.items():
            if path.exists():
                backup=path.with_name(path.name+'.before-shared-authorization')
                if not backup.exists(): shutil.copy2(path,backup)
            atomic_write(path,new,old)

if __name__=='__main__': main()
