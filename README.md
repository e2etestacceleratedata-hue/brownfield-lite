# test-repo

E2E test repository for vd-studio.

## Branches

- **`main`** — empty. Used by tests that verify initialization from scratch (e.g. `features/workflow/dbt-design-phase.feature`, `features/workflow/intent-creation.feature`).
- **`lifecycle-base`** — pre-scaffolded minimal dbt project with seed data. Used by `features/workflow/agent-full-lifecycle.feature` so the agent can skip scaffolding and focus on the design → build → test → validate workflow.

## `lifecycle-base` contents

```
dbt_project.yml              # profile: dbt_fab_spark, seeds land in raw schema
seeds/customers.csv          # 10 rows, columns: customer_id, name, email, signup_date
models/staging/_sources.yml  # declares source('raw', 'customers')
```

The agent still creates `profiles.yml` per-intent (populated with the ephemeral Fabric workspace/lakehouse IDs). After that, `dbt seed` materializes `raw.customers` in the ephemeral lakehouse.
