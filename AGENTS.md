# dotfiles (chezmoi source repo)

This repo is the **chezmoi source state** for this user's machines (Windows 11 primary, plus macOS/Linux). Shared agent conventions are **not** here — they live in `~/.codex/AGENTS.md` (canonical) and `~/.claude/CLAUDE.md` (`@~/.codex/AGENTS.md` + Claude-only notes). This file covers only what bites you *inside this repo*.

## chezmoi gotchas

- **Source filenames are the target paths.** `dot_x` → `~/.x`, `private_*` → 0600, `encrypted_*.age` → decrypted on apply, `run_onchange_*` → re-runs when the hash embedded in its header changes. Renaming a file here silently moves a real dotfile on the next `chezmoi apply`.
- **Unprefixed files land in `$HOME`.** `AGENTS.md` and `CLAUDE.md` here are repo docs, not deployables — `.chezmoiignore` excludes them both (keep it that way: un-ignoring them would make an apply create `~/AGENTS.md`, a second, competing global agent-instruction file above every repo in `~`). Check `chezmoi status` / `chezmoi apply --dry-run` before applying.
- **Age encryption:** `.chezmoi.toml.tmpl` pins the public recipient; the private identity (`~/.config/chezmoi/key.txt`) must be restored out-of-band (NAS blob / Bitwarden) *before* `chezmoi init`, or every `encrypted_*` file fails to decrypt.
- **Fish plugin files are deliberately untracked.** `dot_config/private_fish/fish_plugins` is the single source of truth and `run_onchange_after_install-fish-plugins.sh.tmpl` reconciles it through fisher. Tracking the generated `functions/`/`completions/`/`conf.d` plugin files made fisher fail with "file already exists" on a fresh machine — see `.chezmoiignore`; don't re-add them.

## Landmine: tracked agent-config snapshots drift from the live files

`dot_claude/encrypted_CLAUDE.md.age` and `dot_codex/encrypted_AGENTS.md.age` are encrypted snapshots of the live `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md`. The live files change on whichever host is active (most recently the 2026-07-26 context refactor + Response style section on DESKTOP-O91444G) and the snapshots do not follow automatically. **A `chezmoi apply` overwrites the live instruction files with whatever the snapshots hold** — decrypt and diff against the live files before any apply, and re-encrypt from live after editing them. (`dot_claude/settings.json` is no longer tracked; `.chezmoiignore` excludes `.claude/settings.json`.)

## Shell config portability

These configs deploy to macOS as well as Windows/Linux, so anything added to `dot_bashrc`, `dot_zshrc`, `dot_zprofile`, or the fish config has to work against **BSD userland**: avoid GNU-only flags (`head -n -2`, `sed -i` without a backup arg, `date -d`), or guard on `gtail`/`gsed` from coreutils.

## Commits here

Short imperative subjects, and **no AI co-author / attribution trailers** — for Claude Code and Codex alike. This overrides the default harness behavior, which appends a `Co-Authored-By` trailer.
