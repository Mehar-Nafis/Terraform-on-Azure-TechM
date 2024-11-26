## Data Source

To perform this lab make sure you have an existing resource group with the name of `existing-resource-group`

Create a working directory and navigate to it
```
cd ~/Labs && mkdir data-source-lab && cd data-source-lab
```
Create a main.tf file:
```
vi main.tf
```
Add the following content to main.tf:
```hcl
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}

# Data source to get information about an existing Azure resource group
data "azurerm_resource_group" "existing_rg" {
  name = "existing-resource-group"  
}

# Use the data from the resource group in a new resource
resource "azurerm_storage_account" "example" {
  name                     = "tfexamplestoracc"  # Must be globally unique
  resource_group_name      = data.azurerm_resource_group.existing_rg.name
  location                 = data.azurerm_resource_group.existing_rg.location
  account_tier             = "Standard"          
  account_replication_type = "LRS"               
}
```
Initialize Terraform:
```
terraform init
```
Plan the changes:
```
terraform plan
```
Apply the configuration:
```
terraform apply -auto-approve
```
If you get an error creating, execute the below command
```
az provider register --namespace Microsoft.Storage
```
Apply again
```
terraform apply -auto-approve
```
![image](https://github.com/user-attachments/assets/7b30f3d4-66c8-4bac-ac32-8a83bade9b2c)

Verify
```
az resource list --resource-group existing-resource-group --output table
```
![image](https://github.com/user-attachments/assets/fb0dd9a6-92f4-406d-b31a-95e2304bc4ba)

Clean Up: Destroy the created resources
```
terraform destroy -auto-approve
```
Remove the working directory:
```
cd ~/Labs && rm -rf data-source-lab
```
