# Global Claude Conventions

## Core Principles

### Verification before claims
- Never claim a fix is complete without running typecheck/build/tests and showing output.
- For multi-variant edits (e.g., -C flags, multiple call sites), grep to enumerate ALL occurrences before using replace_all.
- Verify branch/merge state (git status, git log, gh pr view) BEFORE starting implementation work.

### Git Commits
- Do not credit yourself/Claude in commit messages as a coauthor

### Think Before Coding

- If multiple interpretations exist, present them — don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- Before starting implementation, confirm the scope of what I'm asking for. If I say "fix X", fix X, don't also refactor Y.

### Goal-Driven Execution

Transform tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

## Code Search

Use `semble search` to find code by describing what it does or naming a symbol/identifier, instead of grep:

​```bash
semble search "authentication flow" ./my-project
semble search "save_pretrained" ./my-project
semble search "save model to disk" ./my-project --top-k 10
​```

Use `semble find-related` to discover code similar to a known location (pass `file_path` and `line` from a prior search result):

​```bash
semble find-related src/auth.py 42 ./my-project
​```

`path` defaults to the current directory when omitted; git URLs are accepted.

If `semble` is not on `$PATH`, use `uvx --from "semble[mcp]" semble` in its place.

### Workflow

1. Start with `semble search` to find relevant chunks.
2. Inspect full files only when the returned chunk is not enough context.
3. Optionally use `semble find-related` with a promising result's `file_path` and `line` to discover related implementations.
4. Use grep only when you need exhaustive literal matches or quick confirmation of an exact string.

## Environment

- This is a TypeScript-first monorepo ecosystem. Primary runtime is bun.
- When running on remote servers via SSH/cron, use full paths to bun (e.g., `/home/user/.bun/bin/bun`) instead of relying on PATH.

## Long-running commands

- For commands that take >10s, redirect output to a log file (e.g., `command > /tmp/run.log 2>&1 &`) and proactively `tail`/`cat` the log to monitor progress. Do NOT wait silently — read the log.

## macOS shell compatibility
- Avoid GNU-only flags like `head -n -2`, `sed -i` (without backup arg), `date -d`. Use BSD-compatible alternatives or `gtail`/`gsed` via coreutils.

## Bash Execution

- For long-running commands: redirect to log file with `&> /tmp/cmd.log &` and proactively `tail -f` or `read` the log. Never block waiting on output.


## Editing Conventions

- Before bulk replacements, grep for all variants and confirm match list. Prefer explicit per-file edits over `replace_all` for non-trivial patterns.

## Working Style

- Ask me before exploring the codebase for addresses, keys, or configuration values — I likely have them ready to paste.

## Git & Deployment

- Common mappings: staging = develop, not beta.
- Always verify with `git remote -v` and `git branch` before pushing.
- Always run `date +%Y-%m-%d` before writing dates into commits, changelogs, or docs.

## Code Conventions

### General

- Prefer pure functions over classes
- Functions should do one thing well
- Code should flow: imports → helpers → main logic → execution
- Minimize side effects and state mutations

### TypeScript

- **NEVER use `any` type** — use `unknown` with type guards when type is truly unknown
- Use `import type` for type-only imports
- Prefer library utilities over custom implementations (lodash, viem, etc.)

### Solidity / Foundry

- Verification troubleshooting order: (1) check EVM version, (2) byte-diff deployed vs local, (3) try Etherscan V2 verifier-url as universal fallback, (4) Sourcify as last resort.

### Etherscan / Contract Verification

Etherscan V2 replaced chain-specific APIs with a **single unified API key** from etherscan.io. One key covers all 60+ chains via a `chainid` parameter.

- Use `ETHERSCAN_API_KEY`, not `BASESCAN_API_KEY` / `ARBISCAN_API_KEY` etc.
- Foundry: `--etherscan-api-key $ETHERSCAN_API_KEY` works for all chains.
- **Paid-only chains** (no free-tier access): BNB Smart Chain, Base, OP Mainnet, Avalanche C-Chain (and their testnets).
- V1 chain-specific APIs are deprecated. Always use the V2 unified endpoint.

### Block Explorer Scraping & Access

**Never scrape block explorer HTML pages.** On-chain data is JS-rendered and won't appear in curl/fetch responses.

- **Bot-blocked**: `arbiscan.io` (Cloudflare), `snowtrace.io` (CloudFront 403), `ftmscan.com` (empty)
- **Not blocked but useless to scrape**: `etherscan.io`, `basescan.org`, `polygonscan.com` (data is JS-rendered)
- **Takeaway**: Always use the Etherscan V2 unified API (`api.etherscan.io/v2/api?chainid=...`) with an API key.

## Tool Conventions

- **Prefer `jq` over `python -m json.tool`** for JSON processing in the shell
