## Count

Create a directory for the lab
```
cd ~/Labs && mkdir count-lab && cd count-lab 
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

# Resource Group
resource "azurerm_resource_group" "count-rg" {
  name     = "count-rg"
  location = "East US"
}

# Create multiple storage accounts using `count`
resource "azurerm_storage_account" "example" {
  count                   = 3  # Create 3 storage accounts
  name                    = "examplestorage${count.index}"  # Unique name
  resource_group_name     = azurerm_resource_group.count-rg.name
  location                = azurerm_resource_group.count-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
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
Verify
```
az group show --name count-rg
```
```
az storage account list --resource-group count-rg --query "[].name" --output table
```
![image](https://github.com/user-attachments/assets/fc073c4c-df90-40b2-bfc3-e3cf25f34d3f)

Clean Up: 
```
terraform destroy -auto-approve
```
```
cd ~/Labs && rm -rf count-lab
```



