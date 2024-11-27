## Meta Argument: Provider

Set Up the Directory
```bash
cd ~/Labs && mkdir provider-lab && cd provider-lab
```
Create a file named main.tf
```
vi main.tf
```
```
# Azure Provider for East US
provider "azurerm" {
  features {}
  alias    = "eastus"
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}

# Azure Provider for West US
provider "azurerm" {
  features {}
  alias    = "westus"
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}


# Resource Group in East US
resource "azurerm_resource_group" "rg_eastus" {
  provider = azurerm.eastus
  name     = "rg-eastus"
  location = "East US"
}

resource "azurerm_resource_group" "rg_westus" {
  provider = azurerm.westus
  name     = "rg-westus"
  location = "West US"
}

# Storage Account in East US
resource "azurerm_storage_account" "storage_eastus" {
  provider                = azurerm.eastus
  name                    = "tfeastusstorageacct"
  resource_group_name     = azurerm_resource_group.rg_eastus.name
  location                = azurerm_resource_group.rg_eastus.location
  account_tier            = "Standard"
  account_replication_type = "LRS"
}

# Storage Account in West US
resource "azurerm_storage_account" "storage_westus" {
  provider                = azurerm.westus
  name                    = "tfwestusstorageacct"
  resource_group_name     = azurerm_resource_group.rg_westus.name
  location                = azurerm_resource_group.rg_westus.location
  account_tier            = "Standard"
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
Apply the Terraform configuration to create the resources
```
terraform apply -auto-approve
```
![image](https://github.com/user-attachments/assets/dc0ba354-84d1-4088-8327-24bec95ecb9e)

Verify
```
az group list --query "[].{Name:name, Location:location}" -o table
```
![image](https://github.com/user-attachments/assets/0cb1df99-3399-4b5d-95c5-e497c33c0201)

```
az storage account list --query "[].{Name:name, Location:primaryLocation}" -o table
```
![image](https://github.com/user-attachments/assets/fa74d415-179f-40df-a6b2-444234033e95)


Clean Up the Resources
```
terraform destroy -auto-approve
```
```
cd ~/Labs && rm -rf provider-lab
```
