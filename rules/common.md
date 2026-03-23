# Common Development Rules

## Workflow

1. `/write-plan` — read sources, gap matrix, verify assumptions, then output phased plan
2. `/self-review` — check own output: every claim sourced? confidence HIGH? no hallucinations?
3. `/review-plan` — adversarial subagent attacks the plan before execution
4. `/tdd` — write tests first, then implement
5. `/self-review` — check own code before showing
6. `/code-review` — review git diff for security + quality before committing
7. Commit with conventional commits: `<type>: <description>`

## TDD (Mandatory)

1. Write test first (RED) — must fail
2. Implement minimum code (GREEN) — must pass
3. Refactor (IMPROVE) — keep tests green
4. Coverage: 80%+
5. All test types required: unit + integration (`/integration-testing`) + E2E UI (`/ui-testing`)

## Code Quality

- Immutability: new objects, never mutate
- Files: 200-400 lines, 800 max
- Functions: < 50 lines
- Nesting: max 4 levels
- Error handling: explicit, never swallow
- Input validation: at system boundaries

## Security (Before Any Commit)

- No hardcoded secrets
- Parameterized queries only
- Validate all user input
- Auth/authz on all endpoints
- Error messages: no internal details

## Agents

| Agent | When |
|-------|------|
| `architect` | System design |
| `tdd-guide` | New features, bug fixes |
| `code-reviewer` | After writing code |
| `security-reviewer` | Before commits |
| `build-error-resolver` | Build fails |
| `java-reviewer` | Java/Spring Boot |
| `go-reviewer` | Go |
| `typescript-reviewer` | TypeScript/JS |
| `database-reviewer` | Schema/queries |
| `docs-lookup` | Library/API docs |
