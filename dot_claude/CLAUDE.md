# Global Claude Conventions

## Core Principles

---------

### 1. Think Before Coding

Don't assume. Don't hide confusion. Surface tradeoffs.

Before implementing:

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

### 2. Simplicity First

Minimum code that solves the problem. Nothing speculative.

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.
- Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### 3. Surgical Changes

Touch only what you must. Clean up only your own mess.

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution

Define success criteria. Loop until verified.

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

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## Code Conventions

---------

### General

- **Write simple, functional code** that reads top-to-bottom
- Prefer pure functions over classes
- Functions should do one thing well
- Avoid complex abstractions - keep it straightforward
- Code should flow naturally from imports → helpers → main logic → execution
- Each function should have clear inputs and outputs
- Minimize side effects and state mutations

### Typescript

- **NEVER use `any` type** - always use proper TypeScript types
- Use `unknown` when type is truly unknown and add type guards
- Use type imports with `import type` for type-only imports
- Leverage TypeScript's type inference where possible
- Prefer using utilities from libraries over custom implementations
  - e.g. use `lodash` for common operations
  - e.g. use viem utilities for Ethereum-specific types and operations

## Tool Conventions

---------

- **Prefer ast-grep over text-based search tools** (grep/ripgrep) when:
- ast-grep understands syntax trees and matches code semantically affording:
  - avoiding false positives from comments
  - strings
  - similar-looking but structurally different code
- searching for code patterns
- identifying refactoring opportunities
- analyzing code structure -
