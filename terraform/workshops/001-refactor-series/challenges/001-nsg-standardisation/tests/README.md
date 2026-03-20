# Challenge Tests

These tests validate the NSG challenge requirements using static checks.

## Why Script-Based Tests

The challenge intentionally starts in a non-refactored state. Terraform's native `.tftest.hcl` assertions cannot reliably reference locals/resources that do not exist yet, so static checks provide a clearer pass/fail signal for this scenario.

## How To Run

From `challenges` run:

```bash
bash tests/validate_nsg_challenge.sh
```

## What Is Validated

1. The challenge defines a `locals` block.
2. The local rule set is named `nsg_rules`.
3. Rule generation uses one of these looped patterns:
   - `dynamic "security_rule"` in the NSG resource, or
   - a separate `azurerm_network_security_rule` resource with `for_each`.
4. At least one `for_each` exists for the rule generation path.
5. The old hard-coded `AllowEverythingElse` rule is removed.

If any check fails, the script exits with a non-zero code.

## Pro Member Deep Dive
If you want to see the Architect's Cut of this challenge, Pro members on my Substack get access to a 15-minute breakdown where I cover:

- **The Logic:** Why I chose this specific data structure.
- **The "Gotchas":** Common pitfalls when refactoring NSGs that lead to accidental outages.
- **The Comparison:** Watch me live-code the solution and explain the decision-making process.

[Watch the full Solution Walkthrough & Deep Dive on Substack]()