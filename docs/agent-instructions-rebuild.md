# Agent instruction rebuild — 2026-09-05

## Verified source

Read the official [GPT-6 Astra guide: Prompting best practices](https://developers.openai.com/api/docs/guides/latest-model?model=gpt-6-astra#prompting-best-practices) on 2026-09-05. This is the model-specific source; no guessed Cookbook URL is required.

The guide recommends tuning initiative, instruction precedence, writing style, delegation and testing. It describes sensitivity to instruction files and suggests auditing conflicting skills. Delegation guidance is adjustable to the harness, not a universal mandate. These observations support concise working agreements and proportionate verification.

## Resolved decisions

- Keep the shared file and thin Claude import layer, with runtime rules explicitly scoped and existing encrypted source filenames preserved.
- Preserve the failure-implies-fix shorthand, bounded by explicit review-only requests. State push/merge/deploy authorization once and honor prior approval.
- Retain PR follow-through because the handoff records repeated failures to finish that loop. Report pending or failed checks honestly.
- Replace the unsupported `gh pr checks` field `conclusion` with locally verified `name,state,bucket,link`. Remove the invalid draft phrase `rebase --ff-only`.
- Scope Windows facts to that host instead of introducing OS templates. Rediscover other hosts' runtime details when used.
- Keep model and effort selection in config and delegation frequency in explicit tasks and runtime skills. Add no automatic review schedule.
- Retire global updater caps and formal ASD-STE100 rules without transplanting them into unrelated skills. Add no review timeout policy.
- Leave generated Compound content to the plugin. Describe unattended continuation conditionally: an unwired hook is not enforcement.
- Keep decrypted historical material outside this repo. The original study is background evidence, not a newly verified vendor source.

## Validation and maintenance

Sources: `dot_codex/encrypted_AGENTS.md.age` and `dot_claude/encrypted_CLAUDE.md.age`. This document is excluded from deployment by `.chezmoiignore`.

Compare decrypted source bytes with intended text, commit, then dry-run and apply only the two explicit targets. A broad apply could overwrite unrelated local configuration.

Add global instructions for demonstrated recurring problems or explicit preferences. Put specialized procedures in skills. Review for contradictions when a model or harness changes; prose is guidance, not configured enforcement.
