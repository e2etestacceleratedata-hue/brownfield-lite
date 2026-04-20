# brownfield-lite

E2E test fixture repository for [vd-studio](https://github.com/accelerate-data/vd-studio), consumed by the [e2e-test-harness](https://github.com/accelerate-data/e2e-test-harness).

## Purpose

Represents the **brownfield-lite** starting state: a minimal pre-scaffolded dbt project with seed data already committed. The agent skips initial scaffolding and goes straight to the design → build → test → validate workflow.

Paired with [`test-repo`](https://github.com/e2etestacceleratedata-hue/test-repo), which holds the greenfield (empty) starting state.

## Consumed by

| Harness feature | What it exercises |
|---|---|
| `features/workflow/brownfield-lite-agent-full-lifecycle.feature` | 13-scenario full lifecycle: design-approval gate → source profiling → staging model build → data tests → `dbt run` → Fabric lakehouse verification → transform-on-transform (staging → mart) |

## Branches

Only `main` is used. vd-studio only permits `main` at domain creation, so this repo carries the brownfield-lite state on its default branch.

## `main` contents

```
dbt_project.yml              # profile: dbt_fab_spark; seeds land in raw schema; models materialize as table
seeds/customers.csv          # 10 rows — customer_id, name, email, signup_date
models/staging/_sources.yml  # declares source('raw', 'customers')
```

At runtime the agent:

1. Creates `profiles.yml` per-intent (populated with ephemeral Fabric workspace + lakehouse IDs).
2. Runs `dbt seed --target ephemeral_dev` — materializes `raw.customers` in the ephemeral lakehouse.
3. Builds `models/staging/stg_customers.sql` (agent-authored).
4. Adds data tests in `models/staging/_stg_customers.yml` (agent-authored).
5. Runs `dbt run`, then `dbt test`, then validation + mart follow-ons.

See the feature file for the full scenario list.
