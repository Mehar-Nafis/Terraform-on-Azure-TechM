## Capstone 1 : Azure Linux Virtual Machine Creation Using Terraform

### Problem Statement:
As part of a cloud infrastructure team, you are tasked with automating the deployment of a scalable and secure Linux virtual machine on Microsoft Azure. The goal is to create a reusable and modular Terraform configuration that incorporates input variables, output variables, data sources, and Terraform functions.

The configuration must meet the following requirements:

Resource Group and Virtual Network Setup:

Create a new Azure Resource Group and Virtual Network with customizable names and address spaces.
Ensure the Virtual Network contains a subnet with a specific address prefix.
Network Interface and VM Deployment:

Deploy a Network Interface (NIC) linked to the created subnet.
Use the NIC to configure a Linux Virtual Machine with the following characteristics:
Admin credentials provided dynamically via variables.
VM size and name set as input variables.
Password authentication enabled for administrative access.
Integration with Existing Public IP:

Fetch an existing Azure public IP using Terraform's data sources and integrate it with the VM deployment.
Reusable and Modular Configuration:

Use input variables for resources like resource group name, VM size, VNet address space, and admin credentials.
Create output variables to expose the resource group name, network interface ID, public IP, and VM size.
Use Terraform functions (e.g., upper()) to manipulate and demonstrate outputs.
Validation and Cleanup:

Validate the deployment by listing resources and confirming VM creation in Azure.
Ensure the environment can be destroyed without leaving residual resources to minimize costs.



### Solution
Create the Working Directory
```
cd ~/Labs && mkdir vm-lab && cd vm-lab
```
Create and Open main.tf
```
vi main.tf
```
Paste the following code:
```
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id                 = var.subscription_id
}

# Resource Group
resource "azurerm_resource_group" "RG" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "az-net" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
}

# Subnet
resource "azurerm_subnet" "az-subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.az-net.name
  address_prefixes     = [var.subnet_address_prefix]
}

# Network Interface
resource "azurerm_network_interface" "az-net-int" {
  name                = var.nic_name
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "az-linux-vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  size                = var.vm_size

  admin_username      = var.admin_username
  admin_password      = var.admin_password

  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.az-net-int.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

# Output: VM IP (Using a Data Source)
data "azurerm_public_ip" "vm_public_ip" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.RG.name
}

output "vm_public_ip" {
  value       = data.azurerm_public_ip.vm_public_ip.ip_address
  description = "The public IP address of the virtual machine."
}
```
Create variables.tf
```
vi variables.tf
```
Paste the following code:
```
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "tf-resource-grp"
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "Central India"
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
  default     = "az-network"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "internal"
}

variable "subnet_address_prefix" {
  description = "Subnet address prefix"
  type        = string
  default     = "10.0.2.0/24"
}

variable "nic_name" {
  description = "Network interface name"
  type        = string
  default     = "az-nic"
}

variable "vm_name" {
  description = "Virtual machine name"
  type        = string
  default     = "az-linux-vm1"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "ubuntu"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

variable "public_ip_name" {
  description = "Public IP name for the VM"
  type        = string
  default     = "vm-public-ip"
}
```
Create outputs.tf
```
vi outputs.tf
```
Paste the following code:
```
output "resource_group_name" {
  value       = azurerm_resource_group.RG.name
  description = "The name of the created resource group."
}

output "virtual_machine_id" {
  value       = azurerm_linux_virtual_machine.az-linux-vm.id
  description = "The ID of the created Linux virtual machine."
}

output "network_interface_id" {
  value       = azurerm_network_interface.az-net-int.id
  description = "The ID of the created network interface."
}

output "virtual_machine_size" {
  value       = upper(var.vm_size)
  description = "The size of the virtual machine (uppercased for demo purposes)."
}
```
Create terraform.tfvars
```
vi terraform.tfvars
```

Paste the following code:
```
subscription_id = "your-subscription-id"
admin_password  = "admin@1234"
```
Execute Terraform Commands
```
terraform init
```
Plan the Deployment
```
terraform plan
```

Apply the Configuration
```
terraform apply -auto-approve
```
Verify and Cleanup
```
az vm list -o table --resource-group tf-resource-grp
```
Destroy Resources
```
terraform destroy -auto-approve
```
