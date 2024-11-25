## Local Values

Create a directory and navigate inot it
```bash
cd ~/Labs && mkdir locals-lab && cd locals-lab
```
Create a `vars.tf` file with the following content:
```
vi vars.tf
```
```hcl
variable "rg-name" {
  description = "setting up az resource group name"
  default     = "test-resource-group"
}

variable "location" {
  description = "setting up location (region) for resources in az"
  default     = "East US"
}

variable "sub-id" {
  default = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}
```
Next, create a local.tf file with the following content
```
vi local.tf
```
```hcl
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = var.sub-id  #Replace with your subscription id
}

locals {
  custom_tags = {
    Team    = "DevOps"
    company = "CloudThat"
  }
}

resource "azurerm_resource_group" "RG" {
  name     = var.rg-name
  location = var.location
  tags     = local.custom_tags
}

resource "azurerm_storage_account" "example" {
  name                     = "tfexamplestoracc"  # Must be globally unique
  resource_group_name      = var.rg-name
  location                 = var.location
  account_tier             = "Standard"          
  account_replication_type = "LRS"
  tags                     = local.custom_tags            
}
```
Initialize Terraform
```
terraform init
```
Plan the Changes
```
terraform plan
```
Apply the Configuration
```
terraform apply -auto-approve
```
-----------------------------------------------------------------------------------------

![image](https://github.com/user-attachments/assets/02a6af80-2759-4640-8238-5b9ded4782d3)

-----------------------------------------------------------------------------------------
Clean Up
```
terraform destroy -auto-approve
```
```bash
cd ~/Labs && rm -rf locals-lab
```

