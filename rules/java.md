---
paths:
  - "**/*.java"
  - "**/pom.xml"
  - "**/build.gradle"
---

# Java Rules

## Style
- `record` for DTOs/value types (Java 16+)
- Fields `final` by default, defensive copies (`List.copyOf()`)
- `Optional<T>` from finders — never return `null`; use `orElseThrow()`, never `get()`
- Unchecked exceptions for domain errors, with context messages
- Modern features: sealed classes, pattern matching, text blocks, switch expressions

## Spring Boot
- Constructor injection only — no `@Autowired` on fields
- Business logic in service layer — controllers delegate only
- `@Transactional` on service layer; `readOnly = true` for reads
- DTO/record projections — never expose JPA entities in responses
- `FetchType.LAZY` default — use `JOIN FETCH` or `@EntityGraph`

## Testing (TDD)
- JUnit 5 + AssertJ + Mockito
- Testcontainers for integration tests (real DB, not mocks)
- `@WebMvcTest` for controllers, `@DataJpaTest` for repos, `@ExtendWith(MockitoExtension.class)` for services
- Naming: `methodName_scenario_expectedBehavior()` + `@DisplayName`
- Coverage: 80%+ (JaCoCo)

## Security
- Parameterized queries always (`PreparedStatement`, `@Query` with bind params)
- `@Valid` on all `@RequestBody`
- Secrets via `System.getenv()` or Spring config
- Never expose stack traces in API responses
- `mvn dependency-check:check` for CVEs

## Agent: `java-reviewer` — use for all Java code changes
