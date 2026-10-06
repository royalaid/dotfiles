# Shared authorization policy

`home/dot_agents/authorization-policy.md` is the canonical policy. Deploy only
that file and `home/dot_agents/install-authorization-policy.py` with chezmoi,
then run `python3 ~/.agents/install-authorization-policy.py` to preview and
`python3 ~/.agents/install-authorization-policy.py --apply` to merge adapters
into existing machine-local settings. Requires Python 3.11 or newer (standard-library TOML parser). Windows may use
`python` or `py -3`.
Use a fresh session after installation. A second preview must have no changes.

The machine-local `~/.agents/authorization-adapter-state.json` records the exact
Claude entries the installer owns, so regeneration removes only those entries.
Existing custom arrays without `$defaults` stop for reconciliation instead of
being silently changed. Existing OpenCode JSON permission entries retain their
effect; a JSONC layer above existing JSON permissions stops for reconciliation.
Malformed marker blocks stop before any write. File replacement preserves links
and is atomic per file, with concurrent-edit checks before application and before each replacement.
Coordinate a single config writer: filesystem replacement is not a compare-and-
swap against an uncooperative editor in the final check/replace interval. The
multi-file update is not transactional; rerun after an interrupted application.

The installer embeds the same Markdown in Codex's additive
`auto_review.extra_policy`, and Claude's top-level `autoMode.environment` with
`$defaults`. Claude's `allow` entry is extracted from the authorized-review
section. Shared agent entry points reference the canonical file. Existing
settings, providers, hooks, and deny/ask rules remain intact. Existing unmanaged
Codex auto-review or OpenCode JSONC instruction/permission settings require
manual reconciliation; the installer stops rather than overwrite them.

OpenCode loads the file through global `instructions`. Its native URL prompts
cover direct `webfetch` requests to OpenRouter/Fireworks inference endpoints.
They cannot enforce model-provider routing, arbitrary shell HTTP requests,
wrapper commands, payload classification, or project merge/deploy semantics.
OpenCode has no equivalent semantic approval classifier. Inspect the effective
GLM agent and provider base URL before review. Never substitute an advertised
OpenRouter model for the authorized company alias.

The installer changes only homes that exist and Codex configs already present.
Discover the homes used by T3 and environment variables on each host. Its
standard home names are not proof of the loaded paths. Backups preserve the
pre-install files; they remain machine-local and may contain credentials.
Do not commit or print them. Capture changed shared instruction snapshots with
`chezmoi add --encrypt`; machine-local adapter settings stay untracked. Run the
installer again after policy updates or changes to loaded homes.

Verify effective Codex `config/read` and `configRequirements/read`, Claude
`auto-mode config` (no model invocation), and OpenCode `debug config` / agent
metadata. Hash loaded policy text. Verify actual fresh parent/child instruction
loading separately. Semantic model checks with inert requests are separate from
config validation; do not call either a production classifier verdict. Never
execute negative-control requests. Claude model probes remain unavailable while
the personal subscription is exhausted.

References: [Codex config](https://learn.chatgpt.com/docs/config-file/config-reference),
[Claude auto mode](https://code.claude.com/docs/en/auto-mode-config),
[OpenCode permissions](https://opencode.ai/docs/permissions/),
[OpenCode rules](https://opencode.ai/docs/rules/).
