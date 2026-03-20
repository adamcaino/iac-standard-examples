# Challenge: Refactor NSG Into a Standard Pattern

## Scenario

The current Network Security Group (NSG) implementation is intentionally messy. Your task is to refactor it into a cleaner, standardised, and well-architected Terraform pattern.

## Goal

Split the NSG design into:

1. An NSG resource definition.
2. NSG rules generated from a single `locals` data structure.

You may implement the rules in one of two ways:

- Option A: a `dynamic` block inside the NSG resource.
- Option B: separate `azurerm_network_security_rule` resources, looped with `for_each`.

Both options must still loop over the same `locals`-built rule set.

## Requirements

1. Create a `locals` block that defines all NSG rules in a structured format.
2. Ensure rule creation is data-driven from `locals` only.
3. Keep naming conventions consistent and predictable.
4. Preserve rule intent and behaviour after refactoring.
5. Avoid hard-coded duplication across resources.
6. Keep the code readable and easy to extend with new rules.

## Recommended Rule Shape

Use a map or object collection in `locals`, where each rule includes the required Azure NSG fields, such as:

- `priority`
- `direction`
- `access`
- `protocol`
- `source_port_range` or `source_port_ranges`
- `destination_port_range` or `destination_port_ranges`
- `source_address_prefix` or `source_address_prefixes`
- `destination_address_prefix` or `destination_address_prefixes`
- `description` (optional but recommended)

## Implementation Paths

### Path A: Dynamic Block Pattern

- Keep a single NSG resource.
- Use `dynamic "security_rule"` to iterate over local rule data.
- Map each field from the local object into the nested `security_rule` block.

### Path B: Separate Rule Resources Pattern

- Create one NSG resource.
- Create `azurerm_network_security_rule` with `for_each` over the local rule data.
- Link each rule resource to the NSG name and resource group.

## Acceptance Criteria

1. `terraform validate` passes.
2. Rule generation is fully loop-driven from `locals`.
3. No repeated copy-paste rule blocks.
4. Output plan shows the expected NSG and rules.
5. Another operator can add a new rule by changing `locals` only.

## Stretch Goals

1. Add input validation for rule priorities and directions.
2. Add conventions to prevent duplicate priorities.
3. Split local rule data into reusable grouped locals for common environments.

## Suggested Workflow

1. Define local rule objects first.
2. Implement one of the two rule generation patterns.
3. Run `terraform fmt` and `terraform validate`.
4. Run `bash tests/validate_nsg_challenge.sh` to confirm the refactor meets the challenge rules.
5. Review the plan for correctness and readability.

## Deliverable

Refactored Terraform in this challenge folder that demonstrates a standardised NSG pattern using local rule data and loop-based rule generation.
