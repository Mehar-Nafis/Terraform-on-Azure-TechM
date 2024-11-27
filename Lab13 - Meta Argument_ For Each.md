## For Each

Create a directory for the lab
```
cd ~/Labs && mkdir foreach-lab && cd foreach-lab 
```
Create a new file main.tf
```
vi main.tf
```
Add the below lines
```
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}

# Define a map variable for the storage account names and descriptions
variable "storage_accounts" {
  type = map(string)
  default = {
    "foreachstorage1" = "Primary storage account"
    "foreachstorage2" = "Backup storage account"
    "foreachstorage3" = "Log storage account"
  }
}

# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "East US"
}

# Create multiple storage accounts using `for_each` with the map variable
resource "azurerm_storage_account" "example" {
  for_each                = var.storage_accounts
  name                    = each.key  # Use the key as the name
  resource_group_name     = azurerm_resource_group.example.name
  location                = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  tags = {
    Description = each.value  # Use the value as a tag description
  }
}

```
Initialize
```
terraform init
```
Plan
```
terraform plan
```
Apply
```
terraform apply -auto-approve
```
Verify from the Console

----------------------------------------------------------------------------------------
![image](https://github.com/user-attachments/assets/88079c94-63d9-44c0-b149-f77ac3edf971)
----------------------------------------------------------------------------------------


Clean Up: 
```
terraform destroy -auto-approve
```
```
cd ~/Labs && rm -rf foreach-lab
```



