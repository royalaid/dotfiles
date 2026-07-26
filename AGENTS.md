# dotfiles (chezmoi source repo)

This repo is the **chezmoi source state** for this user's machines (Windows 11 primary, plus macOS/Linux). Shared agent conventions are **not** here — they live in `~/.codex/AGENTS.md` (canonical) and `~/.claude/CLAUDE.md` (`@~/.codex/AGENTS.md` + Claude-only notes). This file covers only what bites you *inside this repo*.

## chezmoi gotchas

- **Source filenames are the target paths.** `dot_x` → `~/.x`, `private_*` → 0600, `encrypted_*.age` → decrypted on apply, `run_onchange_*` → re-runs when the hash embedded in its header changes. Renaming a file here silently moves a real dotfile on the next `chezmoi apply`.
- **Unprefixed files land in `$HOME`.** This `AGENTS.md` is itself a source file and is not in `.chezmoiignore`, so an apply would create `~/AGENTS.md` — a second, competing global agent-instruction file above every repo in `~`. Check `chezmoi status` / `chezmoi apply --dry-run` before applying, and decide deliberately.
- **Age encryption:** `.chezmoi.toml.tmpl` pins the public recipient; the private identity (`~/.config/chezmoi/key.txt`) must be restored out-of-band (NAS blob / Bitwarden) *before* `chezmoi init`, or every `encrypted_*` file fails to decrypt.
- **Fish plugin files are deliberately untracked.** `dot_config/private_fish/fish_plugins` is the single source of truth and `run_onchange_after_install-fish-plugins.sh.tmpl` reconciles it through fisher. Tracking the generated `functions/`/`completions/`/`conf.d` plugin files made fisher fail with "file already exists" on a fresh machine — see `.chezmoiignore`; don't re-add them.

## Landmine: the tracked Claude config is stale

`dot_claude/encrypted_CLAUDE.md.age` (~11 KB, last touched 2026-05-28) and `dot_claude/settings.json` (~25 KB) predate the July-2026 global-instruction refactor. The live files are now a 732-byte `~/.claude/CLAUDE.md` shim and a ~1.6 KB `settings.json`. **A `chezmoi apply` would overwrite the current files with the pre-refactor versions** — re-encrypt / re-copy from the live files before any apply. Note also that `~/.codex/AGENTS.md`, the actual canonical global instruction file, is not tracked here at all, so this repo is not a backup of it.

## Shell config portability

These configs deploy to macOS as well as Windows/Linux, so anything added to `dot_bashrc`, `dot_zshrc`, `dot_zprofile`, or the fish config has to work against **BSD userland**: avoid GNU-only flags (`head -n -2`, `sed -i` without a backup arg, `date -d`), or guard on `gtail`/`gsed` from coreutils.

## Commits here

Short imperative subjects, and **no AI co-author / attribution trailers** — for Claude Code and Codex alike. This overrides the default harness behavior, which appends a `Co-Authored-By` trailer.
