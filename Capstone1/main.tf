provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id                 = var.subscription_id
}

# Resource Group
data "azurerm_resource_group" "RG" {
  name = var.resource_group_name
}

data "azurerm_public_ip" "vm_public_ip" {
  resource_group_name = data.azurerm_resource_group.RG.name
  name = var.public_ip_name
}

# Virtual Network
resource "azurerm_virtual_network" "az-net" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = data.azurerm_resource_group.RG.location
  resource_group_name = data.azurerm_resource_group.RG.name
}

# Subnet
resource "azurerm_subnet" "az-subnet" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.az-net.name
  address_prefixes     = [var.subnet_address_prefix]
}

# Network Interface
resource "azurerm_network_interface" "az-net-int" {
  name                = var.nic_name
  location            = data.azurerm_resource_group.RG.location
  resource_group_name = data.azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.vm_public_ip.id
  }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "az-linux-vm" {
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.RG.name
  location            = data.azurerm_resource_group.RG.location
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


