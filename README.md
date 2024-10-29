# Azure Infrastructure as Code

This repository contains Terraform configurations for Azure infrastructure deployment including:

- Virtual Networks with peering
- Virtual Machines
- Network Security Groups
- Key Vault
- Recovery Services
- Log Analytics
- Azure Policy

## Prerequisites

- Azure subscription
- Terraform installed
- Azure CLI installed

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Plan the deployment:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

## Structure

- `main.tf` - Main configuration file
- `variables.tf` - Variable definitions
- `outputs.tf` - Output definitions
- `modules/` - Modular components
  - `networking/` - Network configuration
  - `compute/` - VM configuration
  - `security/` - Security configuration
  - `monitoring/` - Monitoring configuration