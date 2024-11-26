## Functions

Create a new directory for the lab and navigate into it
```
cd ~/Labs && mkdir function_lab && cd function_lab
```
Create the following Terraform configuration files
```
vi vars.tf
```
Press INSERT to start editing the file, and add the following content:
```
variable "volume_name" {
  description = "Name of the volume"
  default     = "new-volume"
}

variable "location" {
  description = "Location for the resources"
  default     = "eastus"
}

variable "resource_group_names" {
  description = "Mapping of regions to resource group names"
  type        = map(string)
  default     = {
    eastus     = "east-resource-group"
    westus     = "west-resource-group"
    centralus  = "central-resource-group"
  }
}

variable "volume_disk_size" {
  description = "Size of the volume disk"
  default     = "5"
}
```
Save the file by pressing ESC and typing :wq! to write the file and quit.

Create the main.tf file:
```
vi main.tf
```
Press INSERT to start editing, and add the following content:
```

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}

resource "azurerm_resource_group" "az_rg" {
  name     = lookup(var.resource_group_names, var.location)
  location = var.location
}

resource "azurerm_managed_disk" "az_disk" {
  name                 = var.volume_name
  location             = azurerm_resource_group.az_rg.location
  resource_group_name  = azurerm_resource_group.az_rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.volume_disk_size

  tags = {
    Name = var.volume_name
  }
}
```
Save the file by pressing ESC and typing :wq! to write the file and quit.
Create the volume.tfvars file
```
vi volume.tfvars
```
```
volume_name = "micro_disk"
location    = "centralindia"

resource_group_names = {
  centralindia = "micro_disk_resource_group"
}

volume_disk_size = "10"
```
Initialize the Terraform configuration:
```
terraform init
```
Run the Terraform plan using the custom values from the volume.tfvars file:
```
terraform plan -var-file="volume.tfvars"
```
Apply the Terraform configuration to create the resources in Azure:
```
terraform apply -var-file="volume.tfvars" --auto-approve
```

![image](https://github.com/user-attachments/assets/7322a6a9-9c81-4b02-b04d-02cd255f0c38)

You can navigate to the Azure portal to verify the newly created resource group and managed disk or use the following Azure CLI command to list the resource groups:
```
az group list --output table
```
![image](https://github.com/user-attachments/assets/992f98a9-681e-4fb8-b1b8-5f51c254a572)

To list the managed disks, use:
```
az disk list --output table
```
![image](https://github.com/user-attachments/assets/22689657-c5ba-455d-9033-32ed0aea85c8)


Clean Up
```
terraform destroy -auto-approve
```
```
cd ~/Labs && rm -rf function_lab
```
