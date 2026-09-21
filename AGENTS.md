# dotfiles (chezmoi source repo)

This repo manages dotfiles for Windows, macOS, and Linux. `.chezmoiroot` selects `home/` as the deployable source state. This root `AGENTS.md` contains repo-specific guidance and stays outside the deployment tree.

Shared conventions live in `~/AGENTS.md`, stored as `home/encrypted_AGENTS.md.age`. Codex and OpenCode use symlinks to that file. Claude imports it through `~/.codex/AGENTS.md`. Read `docs/shared-agent-instructions.md` when changing these files or their loading paths.

## chezmoi gotchas

- **Source filenames determine target paths.** Under `home/`, `dot_x` maps to `~/.x`, `private_*` sets private permissions, and `encrypted_*.age` decrypts on apply. Renaming a source entry can move a real dotfile on the next apply.
- **Keep repo docs outside `home/`.** Root `AGENTS.md`, `CLAUDE.md`, and `docs/` stay local to this repo. Unprefixed deployable files belong under `home/`. Check `chezmoi status` and a targeted `chezmoi apply --dry-run` before applying.
- **Age encryption:** `home/.chezmoi.toml.tmpl` pins the public recipient. Restore the private identity at `~/.config/chezmoi/key.txt` out of band before `chezmoi init`.
- **Fish plugin files stay untracked.** `home/dot_config/private_fish/fish_plugins` is the source of truth. The `run_onchange` script reconciles plugins through fisher. Tracking generated plugin files caused "file already exists" failures. Preserve the exclusions in `home/.chezmoiignore`.

## Landmine: tracked agent-config snapshots drift from the live files

`home/encrypted_AGENTS.md.age` and `home/dot_claude/encrypted_CLAUDE.md.age` are snapshots of the live instructions. Edits on a host do not update those snapshots automatically. Compare source and live content before applying. After editing the live shared agreement, use `chezmoi add --encrypt ~/AGENTS.md` to capture it.

Codex and OpenCode entry points are symlink templates. Preserve the links when adding them with `--template-symlinks`. Claude settings remain machine-local and excluded in `home/.chezmoiignore`.

## Shell config portability

These configs deploy to macOS as well as Windows/Linux, so anything added to `home/dot_bashrc`, `home/dot_zshrc`, `home/dot_zprofile`, or the fish config has to work against **BSD userland**: avoid GNU-only flags (`head -n -2`, `sed -i` without a backup arg, `date -d`), or guard on `gtail`/`gsed` from coreutils.

## Commits here

Short imperative subjects, and **no AI co-author / attribution trailers** — for Claude Code and Codex alike. This overrides the default harness behavior, which appends a `Co-Authored-By` trailer.
