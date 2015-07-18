" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
        if &compatible
                set nocompatible               " Be iMproved
        endif

        " Required:
        set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/vimproc.vim', {
                        \ 'build' : {
                        \     'windows' : 'tools\update-dll-mingw',
                        \     'cygwin' : 'make -f make_cygwin.mak',
                        \     'mac' : 'make -f make_mac.mak',
                        \     'linux' : 'make',
                        \     'unix' : 'gmake',
                        \    },
                        \ }

NeoBundle 'Shougo/neocomplete'
call neobundle#config('neocomplete', {
                        \ 'lazy' : 1,
                        \ 'autoload' : {
                        \   'insert' : 1,
                        \ }})

NeoBundle 'Shougo/neosnippet'
call neobundle#config('neosnippet', {
                        \ 'lazy' : 1,
                        \ 'autoload' : {
                        \   'insert' : 1,
                        \   'filetypes' : 'snippet',
                        \ }})
" NeoBundle 'git@github.com:Shougo/neocomplcache-snippets-complete.git'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/neobundle-vim-scripts'
NeoBundle 'Shougo/unite.vim',
call neobundle#config('unite.vim',{
                        \ 'lazy' : 1,
                        \ 'autoload' : {
                        \   'commands' : [{ 'name' : 'Unite',
                        \                   'complete' : 'customlist,unite#complete_source'},
                        \                 'UniteWithCursorWord', 'UniteWithInput']
                        \ }})

NeoBundle 'xolox/vim-misc'
NeoBundle 'kien/ctrlp.vim/'
NeoBundle 'mbbill/undotree'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-surround'
NeoBundle 'bling/vim-airline' 
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'christoomey/vim-tmux-navigator'

"Ctags stuff and related
NeoBundle 'xolox/vim-easytags'

"Ruby
NeoBundleLazy 'vim-ruby/vim-ruby'
autocmd FileType ruby NeoBundleSource vim-ruby

"Nim
NeoBundleLazy 'zah/nimrod.vim'
autocmd FileType nim NeoBundleSource nimrod.vim

"Python
NeoBundle 'klen/python-mode'
NeoBundle 'nvie/vim-pyunit'
autocmd FileType python NeoBundleSource python-mode
autocmd FileType python NeoBundleSource vim-pyunit

"C & C++
NeoBundle 'vim-scripts/c.vim'
autocmd FileType c,cpp NeoBundleSource c.vim

"Rust
NeoBundleLazy 'rust-lang/rust.vim'
NeoBundleLazy 'phildawes/racer', {
      \   'build' : {
      \     'mac': 'cargo build --release',
      \     'unix': 'cargo build --release',
      \   }
      \ }
autocmd FileType rs NeoBundleSource rust.vim
autocmd FileType rs NeoBundleSource racer

"WebDevStuff
"HTML5
NeoBundle 'othree/html5.vim'
autocmd FileType html NeoBundleSource html5.vim

"Vim JavaScript page recommends
"http://oli.me.uk/2013/06/29/equipping-vim-for-javascript/
NeoBundleLazy 'jelera/vim-javascript-syntax'
NeoBundleLazy 'pangloss/vim-javascript'
NeoBundleLazy 'othree/javascript-libraries-syntax.vim'
NeoBundleLazy 'marijnh/tern_for_vim'
autocmd FileType javascript NeoBundleSource javascript-libraries-syntax
autocmd FileType javascript NeoBundleSource vim-javascript-syntax
autocmd FileType javascript NeoBundleSource vim-javascript
autocmd FileType javascript NeoBundleSource tern_for_vim

"CoffeeScript
NeoBundleLazy 'kchmck/vim-coffee-script'
NeoBundleLazy 'lukaszkorecki/CoffeeTags'
autocmd FileType coffee NeoBundleSource vim-coffee-script
autocmd FileType coffee NeoBundleSource CoffeeTags 

"TypeScript
NeoBundleLazy 'leafgarland/typescript-vim'
autocmd FileType typescript NeoBundleSource typescript-vim

"TypeScript & Javascript
NeoBundleLazy 'jason0x43/vim-js-indent'
autocmd FileType typescript, javascript NeoBundleSource vim-js-indent

"CSS related
NeoBundleLazy 'tpope/vim-haml'
autocmd FileType haml NeoBundleSource vim-haml
NeoBundleLazy 'groenewege/vim-less'
autocmd FileType less NeoBundleSource vim-less
NeoBundleLazy 'hail2u/vim-css3-syntax'
autocmd FileType css NeoBundleSource vim-css3-syntax
NeoBundleLazy 'lilydjwg/colorizer'
autocmd FileType css NeoBundleSource colorizer
call neobundle#end()

" Required:
filetype plugin indent on

"Airline Powerline fonts
let g:airline_powerline_fonts = 1
"Remap leader to comma
let mapleader = ","
colorscheme Tomorrow-Night-Eighties
set background=dark
set t_Co=256
set guifont=DejaVu\ Sans\ Mono:12
"Not Suck Tips
set laststatus=2 
set ruler 
set showcmd 
set showmode 
set number
"Not Suck Search
set incsearch 
set ignorecase 
set smartcase 
set hlsearch
"Set Indentation
set expandtab
set autoindent
syntax on
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#min#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
let g:neocomplete#enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplete#source#dictionary#dictionaries = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" NeoBundle key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
        return pumvisible() ? neocomplete#close_popup() : "\<CR>" 
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible () ? "\<C-p>" : "\<S-TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomple#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^.     ]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *	]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *	]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
"
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

map <leader>n :NERDTreeToggle<CR>
map <Leader>t :TagbarToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif 
" Send more characters for redraws
set ttyfast

" Enable mouse use in all modes
set mouse=a

" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2

"https://github.com/HansCz/dotfiles-vim/blob/master/keybindings.vim
"vimdiff current vs git head (fugitive extension)
nnoremap <Leader>gd :Gdiff<cr>
"switch back to current file and closes fugitive buffer
nnoremap <Leader>gD :diffoff!<cr><c-w>h:bd<cr>
" git stuff
nnoremap <leader>gdc :Git diff --cached<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gst :Gstatus<CR>

"Tab management (http://blog.chrisbe.st/articles/coding/two-years-of-vim)
nnoremap <C-t> :tabnew<CR>
nnoremap <C-b> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>
inoremap <C-t> <Esc>:tabnew<CR>
inoremap <C-b> <Esc>:tabprevious<CR>i
inoremap <C-n> <Esc>:tabnext<CR>i

"Fuck colon, aquire semicolon
nnoremap ; :

set bs=indent,eol,start     " Backspace over everything in insert mode"
"Tab defaults
set ai
set sw=2 "Shift width, >>"
set ts=2 "Tab stop"
set sts=2 "Soft Tab Stop"
set et "expand tabs"
set textwidth=79

" Mark down file type
au BufRead,BufNewFile *.md set filetype=markdown
" HTML (tab width 2 chr, no wrapping)
autocmd FileType html set textwidth=0
"C & C++
autocmd FileType c set cindent
autocmd FileType c set ts=4
autocmd FileType c set sts=4
autocmd FileType c set sw=4

" Python (tab width 4 chr, wrap at 79th char)
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
"Haskell Tab specific option via (http://www.haskell.org/haskellwiki/Vim)
autocmd FileType haskell set tabstop=8 "A tab is 8 spaces
autocmd FileType haskell set expandtab "Always uses spaces instead of tabs
autocmd FileType haskell set softtabstop=4 "Insert 4 spaces when tab is pressed
autocmd FileType haskell set shiftwidth=4 "An indent is 4 spaces
autocmd FileType haskell set smarttab "Indent instead of tab at start of line
autocmd FileType haskell set shiftround "Round spaces to nearest shiftwidth multiple
autocmd FileType haskell set nojoinspaces "Don't convert spaces to tabs
" use ghc functionality for haskell files
au Bufenter *.hs compiler hlint
let g:haddock_browser = "/usr/bin/firefox"
let g:ghc = "/usr/bin/ghc"
