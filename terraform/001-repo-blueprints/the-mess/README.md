# The Mess - A Deliberately Bad Terraform Landing Zone

This is intentionally terrible infrastructure code. It deploys a complete landing zone but follows NONE of the best practices. Use this as a reference for what NOT to do.

## What's Wrong With This?

- **Everything in main.tf** - No modules, no separation of concerns
- **Terrible naming conventions** - Resource names like `vnet_main_network_prod_uat` and `linux_machine_uat_prod_environment_server`
- **Security nightmare** - Passwords stored in plaintext defaults, NSG allows everything
- **No organization** - Variables have cryptic names like `xxx` and `loc`
- **Hardcoded values** - Subnet ranges, VM sizes, everything hardcoded
- **Tight coupling** - NSG and route table associations scattered everywhere
- **No documentation** - Only sarcastic comments
- **Security group wide open** - Allows all traffic from everywhere
- **Shared passwords** - Both VMs' passwords stored in the same key vault without separation
- **Poor variable names** - `xxx`, `env`, `loc` tell you nothing

## What Does It Deploy?

- A resource group
- A virtual network with address space 10.0.0.0/16
- Two subnets (Windows: 10.0.1.0/24, Linux: 10.0.2.0/24)
- One NSG shared across both subnets (dangerously open)
- One route table shared across both subnets
- A Windows Server 2022 VM
- An Ubuntu 22.04 LTS VM
- One shared Key Vault containing both admin passwords

## How to Deploy (If You Dare)

1. Authentication
``` bash
az login
```

2. Plan and Apply
```bash
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

3. Destroy
```bash
terraform destroy -var-file=terraform.tfvars
```

## The Lesson

This is what happens when you:
- Don't think about naming conventions
- Put everything in one file
- Use cryptic variable names
- Don't separate concerns
- Ignore security best practices
- Don't document your code

Compare this to `/the-standard` to see how it should be done - or swing over to my [Substack](https://iacstandard.substack.com/) to watch me pull this mess apart and refactor it step-by-step.
