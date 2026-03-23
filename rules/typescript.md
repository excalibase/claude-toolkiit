---
paths:
  - "**/*.ts"
  - "**/*.tsx"
  - "**/*.js"
  - "**/*.jsx"
---

# TypeScript Rules

## Type Safety
- No `any` — use `unknown` and narrow, or precise types
- `interface` for object shapes, `type` for unions/intersections
- Explicit return types on exported functions
- `const` by default, `let` only when reassignment needed
- Zod for runtime validation at system boundaries

## Async
- Always `await` or `.catch()` promises — no floating promises
- `Promise.all()` for independent async ops — no sequential `await` in loops
- `for...of` not `forEach` with async callbacks

## React/Next.js
- Exhaustive dependency arrays in hooks
- Immutable state updates (spread, never mutate)
- Stable `key` props (not array index)
- Derive values during render, not in `useEffect`

## Testing (TDD)
- UI E2E: Playwright (`/ui-testing`)
- API E2E: Jest + graphql-request/axios (`/integration-testing`)
- No `console.log` in production code
- Coverage: 80%+

## Security
- Secrets via `process.env` — validate at startup
- Never `eval()` or `new Function()` with user input
- Sanitize HTML — no raw `innerHTML` / `dangerouslySetInnerHTML`
- Parameterized queries for SQL/NoSQL

## Agent: `typescript-reviewer` — use for all TS/JS code changes
