# Global Claude Conventions

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
