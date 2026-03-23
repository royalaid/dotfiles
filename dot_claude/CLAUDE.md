# Global Claude Conventions

## Core Principles

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

## Environment

- This is a TypeScript-first monorepo ecosystem. Primary runtime is bun.
- When running on remote servers via SSH/cron, use full paths to bun (e.g., `/home/user/.bun/bin/bun`) instead of relying on PATH.

## Working Style

- Ask me before exploring the codebase for addresses, keys, or configuration values — I likely have them ready to paste.

## Git & Deployment

- Common mappings: staging = develop, not beta.
- Always verify with `git remote -v` and `git branch` before pushing.

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

- **Prefer ast-grep over text-based search** for structural/semantic code pattern matching (avoids false positives from comments, strings, structurally different code)
- **Prefer `jq` over `python -m json.tool`** for JSON processing in the shell
