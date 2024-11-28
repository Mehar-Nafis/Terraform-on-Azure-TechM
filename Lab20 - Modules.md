## Terraform Modules

### Custom Modules

Create a new directory for the lab and navigate into it
```
cd ~/Labs && mkdir modules-lab && cd modules-lab 
```
#### Write the Root Module.
Create the main.tf file: This is the entry point for your Terraform configuration.
```
vi main.tf
```
Press INSERT to start editing the file, and add the following content:
```
# main.tf
# main.tf
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"
}

module "resource_group" {
  source = "./modules/resource_group"
  rg_name = var.rg_name
  location = "East US"
}

module "storage_account" {
  source               = "./modules/storage_account"
  rg_name              = module.resource_group.name
  storage_account_name = var.storage_account_name
  location             = module.resource_group.location
}
```
Save the file by pressing ESC and typing :wq! to write the file and quit.

Create the variales file 
```
vi variables.tf
```
Press INSERT to start editing, and add the following content:
```
# variables.tf

variable "rg_name" {
  description = "Name of the Resource Group"
  type        = string
  default     = "meharmoduleslab-rg"
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
  default     = "East US"
}

variable "storage_account_name" {
  description = "Name of the Storage Account"
  type        = string
  default     = "meharmoduleslabstorage"
}
```
Create the outputs file
```
vi output.tf
```
Press INSERT to start editing, and add the following content
```
# outputs.tf

output "resource_group_name" {
  value = module.resource_group.name
}

output "storage_account_name" {
  value = module.storage_account.name
}
```

#### Create Terraform Modules
Modul for resource group : Create a directory modules/resource_group 
```
mkdir -p modules/resource_group && cd modules/resource_group
```
Create the main file
```
vi main.tf
```
Press INSERT to start editing, and add the following content:
```
# modules/resource_group/main.tf

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}
```
Save the file by pressing ESC and typing :wq! to write the file and quit.

Create the variables file
```
vi variables.tf
```
Press INSERT to start editing, and add the following content
```
# modules/resource_group/variables.tf

variable "rg_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region for the Resource Group"
  type        = string
}
```
Save the file by pressing ESC and typing: wq! to write the file and quit.

Create the outputs file
```
vi output.tf
```
Press INSERT to start editing, and add the following content:
```
# modules/resource_group/outputs.tf

output "name" {
  value = azurerm_resource_group.rg.name
}

output "location" {
  value = azurerm_resource_group.rg.location
}
```
Save the file by pressing ESC and typing: wq! to write the file and quit.

Module for Storage Account : Create a directory within modules
```
cd ~/Labs/modules-lab/modules && mkdir storage_account && cd storage_account
```
Create the main file
```
vi main.tf
```
Press INSERT to start editing, and add the following content
```
# modules/storage_account/main.tf

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```
Save the file by pressing ESC and typing: wq! to write the file and quit.

Create the variables file
```
vi variables.tf
```
Press INSERT to start editing, and add the following content:
```
# modules/storage_account/variables.tf

variable "rg_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the Storage Account"
  type        = string
}
```
Save the file by pressing ESC and typing: wq! to write the file and quit.

Create the outputs file
```
vi output.tf
```
Press INSERT to start editing, and add the following content:
```
# modules/storage_account/outputs.tf

output "name" {
  value = azurerm_storage_account.storage.name
}
```
Save the file by pressing ESC and typing: wq! to write the file and quit.

Your directory structure should look like below.

![image](https://github.com/user-attachments/assets/3de9c956-868b-4e46-b126-cbf200c5408c)

Run the following command to initialize.
```
cd ~/Labs/modules-lab
```
```
terraform init 
```
To see what resources Terraform will create, run:
```
terraform plan
```
Run the following command to deploy the resources:
```
terraform apply -auto-approve
```
Type yes to confirm the deployment.

Verify Resources in Azure

To destroy the resources, run
```
terraform destroy -auto-approve
```
