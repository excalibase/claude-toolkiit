# claude-skills

A curated Claude Code toolkit: **44 skills**, **11 agents**, and **4 rules** for full-stack development with TDD, security, and code review built in.

Built for TypeScript/React + Java/Spring Boot + Go + PostgreSQL/MySQL stacks. Works globally across all your projects via symlink.

## What Problem This Solves

Claude Code is powerful out of the box, but it doesn't enforce a development workflow. Without guidance it will:
- Skip planning and jump straight to code
- Write code without tests
- Miss security issues
- Not review its own output

This toolkit gives Claude a structured workflow (plan → test → implement → review) and domain knowledge for your stack, so every session follows best practices automatically.

## How Claude Code Extensions Work

Claude Code has three extension types. Each lives in a different place and serves a different purpose:

| Type | Location | Purpose | How it loads |
|------|----------|---------|-------------|
| **Skills** | `~/.claude/skills/<name>/SKILL.md` | On-demand workflows you invoke with `/skill-name` | Loaded when you invoke it, or when Claude decides it's relevant |
| **Agents** | `~/.claude/agents/<name>.md` | Specialized subagents Claude delegates to | Claude launches them in isolated contexts for focused tasks |
| **Rules** | `~/.claude/rules/<name>.md` | Always-on coding standards | Auto-loaded every session; language rules trigger only for matching files |

**Skills** = "do this task" (e.g., `/tdd`, `/code-review`)
**Agents** = "delegate to this expert" (e.g., `java-reviewer` reviews your Java code)
**Rules** = "always follow these standards" (e.g., TDD mandatory, no hardcoded secrets)

## Quick Start

### 1. Clone this repo

```bash
cd ~/Documents/duk
git clone <this-repo-url> claude-skills-v2
```

### 2. Run the install script

```bash
cd claude-skills-v2
./install.sh
```

This creates three symlinks:
- `~/.claude/skills` → `./skills/`
- `~/.claude/agents` → `./agents/`
- `~/.claude/rules` → `./rules/`

### 3. Verify

```bash
ls -la ~/.claude/skills ~/.claude/agents ~/.claude/rules
```

Done. Open Claude Code in any project — skills, agents, and rules are all active.

## Recommended Workflow

This is the development workflow enforced by `rules/common.md`:

```
/write-plan  →  Read sources, gap matrix, verify assumptions, output phased plan
     ↓
/self-review →  Check: every claim sourced? confidence HIGH? no hallucinations?
     ↓
/review-plan →  Adversarial subagent finds problems before execution
     ↓
/tdd         →  Write tests FIRST, then implement (RED → GREEN → REFACTOR)
     ↓
/self-review →  Check own code before showing
     ↓
/code-review →  Review git diff for security + quality
     ↓
commit       →  Conventional commits (feat:, fix:, refactor:, etc.)
```

For quick fixes, skip straight to `/tdd`. For exploring a new codebase, start with `/codebase-onboarding`.

## Repo Structure

```
claude-skills-v2/
├── skills/          — 44 skill directories (symlinked as ~/.claude/skills)
├── agents/          — 11 agent .md files (symlinked as ~/.claude/agents)
├── rules/           — 4 rule .md files (symlinked as ~/.claude/rules)
├── install.sh       — one-command setup
└── README.md
```

## Adding a New Skill

1. Create a directory:
   ```bash
   mkdir skills/my-skill
   ```

2. Create `SKILL.md` with frontmatter:
   ```markdown
   ---
   name: my-skill
   description: What it does and when Claude should use it.
   argument-hint: [optional hint shown in autocomplete]
   ---

   # My Skill

   Instructions for Claude...
   ```

3. Done — live immediately as `/my-skill`. No restart needed.

### Frontmatter Reference

| Field | Required | Description |
|-------|----------|-------------|
| `name` | No | Slash command name (defaults to directory name) |
| `description` | Recommended | What it does + when to use. Claude reads this to decide when to auto-trigger. |
| `argument-hint` | No | Hint shown during autocomplete (e.g., `[issue-number]`) |
| `disable-model-invocation` | No | `true` = only you can invoke, Claude won't auto-trigger |
| `user-invocable` | No | `false` = hidden from `/` menu, background knowledge only |
| `allowed-tools` | No | Restrict which tools Claude can use when skill is active |
| `model` | No | Override model for this skill (e.g., `opus`) |
| `context` | No | `fork` = run in isolated subagent context |

### Skill Directory Structure

```
my-skill/
├── SKILL.md          # required — main instructions
├── reference.md      # optional — detailed docs loaded on demand
├── examples/
│   └── sample.md     # optional — example output
└── scripts/
    └── helper.sh     # optional — scripts Claude can run
```

## Safe Development

Since this repo is live via symlink, work in a copy to avoid disrupting active skills:

```bash
cp -r ~/Documents/duk/claude-skills-v2 ~/Documents/duk/claude-skills-dev
# ... make changes in the copy ...
cd ~/Documents/duk/claude-skills-dev && ./install.sh   # swap when ready
```

---

## All Skills (44)

### Planning & Review
| Skill | Description |
|-------|-------------|
| `/write-plan` | Read sources, gap matrix, verify assumptions, output phased plan with testing criteria |
| `/review-plan` | Adversarial subagent review of a plan before execution |
| `/project-review` | Whole-project quality audit: architecture, security, tests, docs, dependencies |
| `/architecture-review` | Deep architecture review: separation of concerns, scalability, design patterns |

### Development
| Skill | Description |
|-------|-------------|
| `/tdd` | Test-Driven Development cycle (RED → GREEN → REFACTOR) |
| `/build-fix` | Incrementally fix build/type errors one at a time |
| `/refactor-clean` | Safely remove dead code with test verification at every step |
| `/code-review` | Security + quality review of uncommitted git changes |
| `/quality-gate` | Run lint, type-check, format checks |
| `/checkpoint` | Save and verify workflow milestones with git |
| `/search-first` | Research before coding — search for existing libs/tools/patterns first |

### Testing
| Skill | Description |
|-------|-------------|
| `/integration-testing` | API/server E2E testing with Jest (GraphQL, REST, docker-compose) |
| `/ui-testing` | Playwright browser E2E testing (Page Object Model, CI/CD, flaky tests) |

### Code Quality
| Skill | Description |
|-------|-------------|
| `/self-check` | Quality gate checklist for tests and assertions |
| `/self-review` | Check own output: every claim sourced? confidence HIGH? no hallucinations? |

### Research & Onboarding
| Skill | Description |
|-------|-------------|
| `/deep-research` | Multi-source web research with cited reports (requires firecrawl/exa MCP) |
| `/db-researcher` | Research a database engine's capabilities before adding support |
| `/codebase-onboarding` | Orient in a new codebase — structure, patterns, entry points |
| `/architecture-decision-records` | Write ADRs for architectural decisions |

### Database
| Skill | Description |
|-------|-------------|
| `/postgres-patterns` | PostgreSQL query patterns, indexing, RLS, connection pooling |
| `/mysql-patterns` | MySQL schema design, queries, JDBC gotchas, HikariCP config |
| `/mongodb-patterns` | MongoDB document design, aggregation pipeline, indexes |
| `/jpa-patterns` | JPA/Hibernate entity design, relationships, query optimization |
| `/database-migrations` | Safe migration patterns across PostgreSQL, MySQL, and ORMs |

### Backend & Security
| Skill | Description |
|-------|-------------|
| `/backend-patterns` | General backend architecture patterns |
| `/api-design` | REST and GraphQL API design best practices |
| `/security-review` | Security audit checklist |
| `/security-scan` | Automated security scanning patterns |

### DevOps
| Skill | Description |
|-------|-------------|
| `/docker-patterns` | Docker and docker-compose best practices |
| `/deployment-patterns` | Deployment strategies and CI/CD patterns |

### Java / Spring Boot
| Skill | Description |
|-------|-------------|
| `/java-coding-standards` | Java coding standards (naming, immutability, Optional, streams) |
| `/springboot-patterns` | Spring Boot architecture patterns |
| `/springboot-tdd` | Spring Boot TDD with JUnit 5, Mockito, Testcontainers |
| `/springboot-security` | Spring Security best practices |
| `/springboot-verification` | Spring Boot verification loop (build, tests, security, diff review) |

### Go
| Skill | Description |
|-------|-------------|
| `/golang-patterns` | Idiomatic Go patterns and conventions |
| `/golang-testing` | Go testing: table-driven, benchmarks, fuzzing |

### TypeScript / React
| Skill | Description |
|-------|-------------|
| `/react-best-practices` | React/Next.js performance optimization (Vercel) |
| `/frontend-patterns` | React/Next.js state management, performance, UI patterns |
| `/coding-standards` | Universal TS/JS/React/Node.js coding standards |

### Session Management
| Skill | Description |
|-------|-------------|
| `/summary` | End-of-session summary — capture what was done, update memory |
| `/continuous-learning` | Auto-extract reusable patterns from sessions |
| `/skill-create` | Analyze git history to auto-generate skills from repo patterns |
| `/strategic-compact` | Smart context compaction timing for long sessions |

---

## All Agents (11)

Agents live in `agents/`. Claude delegates to them automatically based on the task.

| Agent | Purpose | Auto-triggers when |
|-------|---------|-------------------|
| `architect` | System design and architectural decisions | Architectural questions |
| `tdd-guide` | Guides TDD process step by step | New features, bug fixes |
| `code-reviewer` | Reviews code for correctness and quality | After writing/modifying code |
| `security-reviewer` | Finds security vulnerabilities | Before commits, sensitive code |
| `build-error-resolver` | Diagnoses and fixes build errors | Build failures |
| `refactor-cleaner` | Identifies and removes dead code | Code cleanup tasks |
| `database-reviewer` | Reviews schemas and queries (PostgreSQL focus) | Database work |
| `docs-lookup` | Fetches library/API docs via Context7 MCP | API/library questions |
| `java-reviewer` | Java/Spring Boot review (JPA, security, concurrency) | Working on `*.java` files |
| `go-reviewer` | Go review (concurrency, error handling, idioms) | Working on `*.go` files |
| `typescript-reviewer` | TS/JS review (type safety, async, React, Node.js) | Working on `*.ts`/`*.tsx` files |

---

## All Rules (4)

Rules live in `rules/` and are loaded into every session automatically. Language-specific rules use `paths:` frontmatter so they only activate when Claude works on matching files.

| Rule | Triggers on | What it enforces |
|------|------------|-----------------|
| `common.md` | Always | Workflow (write-plan → self-review → review-plan → tdd → code-review → commit), code quality, security checklist, agent table |
| `java.md` | `**/*.java`, `**/pom.xml` | Immutable records, constructor injection, `@Transactional` on services, JUnit 5 + Testcontainers, parameterized queries |
| `golang.md` | `**/*.go` | `gofmt`, error wrapping, context-first params, table-driven tests, `go test -race`, goroutine safety |
| `typescript.md` | `**/*.ts`, `**/*.tsx`, `**/*.js` | No `any`, Zod validation, `Promise.all` for parallel work, Playwright + Jest testing, no `console.log` |

---
