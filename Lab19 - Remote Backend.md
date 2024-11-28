## Remote Backend

### Task 1: Setup the environment

Create the directory
```bash
mkdir ~/Labs/remote-backend-lab && cd ~/Labs/remote-backend-lab && mkdir Task1 && cd Task1
```

Create a file provider.tf for the Azure provider configuration.
```
vi provider.tf
```
Add the following content
```
# Azure Provider for East US
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}
```
Save and exit the file (ESCAPE + :wq!).

Define resources to create an Azure Storage Account. 
```
vi storage.tf
```
Add the following content
```
resource "azurerm_resource_group" "rg" {
  name     = "tf-backend-rg"
  location = "East US"
}

resource "azurerm_storage_account" "sa" {
  name                     = "mytfstatestorage1234" # Ensure globally unique name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    versioning_enabled = true
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "tfstate-container"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
}

```
Save and exit the file.

Initialize Terraform and Apply Configuration
```
terraform init
```
```
terraform plan
```
```
terraform apply -auto-approve
```

### Task 2: Configure Remote Backend 

Move to another sub Directory to utilize the storage as the backend
```
cd .. && mkdir Task2 && cd Task2
```
Create a new resource file vm.tf.
```
vi vm.tf
```
Add the following content
```
# Azure Provider for East US
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}

data "azurerm_resource_group" "rg" {
  name = "tf-backend-rg"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "test-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}
```
Run the following Terraform commands
```
terraform init
```
```
terraform plan
```
```
terraform apply -auto-approve
```
Notice the State at local.
Create a file backend.tf to configure Terraform's remote backend.
```
vi backend.tf
```
Add the following content:
```
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-backend-rg"
    storage_account_name = "mytfstatestorage1234" # Replace with your storage account name
    container_name       = "tfstate-container"
    key                  = "terraform.tfstate"
  }
}
```
Save and exit the file.
Migrate to the Remote Backend by Reinitializing Terraform to configure the remote backend:
```
terraform init -migrate-state
```
Verify the Remote State by navigating to the Azure Portal.

Clean up: 
```
terraform destroy -auto-approve
```
```
cd ~/remote-backend-lab/Task1
```
```
terraform destroy -auto-approve
```
```
cd ~/Labs && rm -rf remote-backend-lab
```
