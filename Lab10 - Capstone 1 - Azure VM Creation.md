## Capstone

### Problem Statement
As part of a cloud infrastructure team, you are tasked with automating the deployment of a scalable and secure Linux virtual machine on Microsoft Azure. The goal is to create a reusable and modular Terraform configuration that incorporates specific input variables (with clearly defined data types and default values), and specific output variables and utilizes Terraform functions to manipulate outputs.

### Requirements:

#### Inputs
* nic_name (type: string, default: "az-nic") - Name of the network interface.
* vm_name (type: string, default: "az-linux-vm1") - Name of the Linux virtual machine.
* vm_size (type: string, default: "Standard_D2s_v3") - Size of the virtual machine.
* admin_username (type: string, default: "ubuntu") - Administrator username for the virtual machine.
* admin_password (type: string, sensitive) - Administrator password for the virtual machine.
  
#### Resources
* Create a Network Interface (azurerm_network_interface.az-net-int) linked to the subnet.
* Deploy a Linux Virtual Machine (azurerm_linux_virtual_machine.az-linux-vm) with the following configuration:
        * Attach the NIC created above.
        * Use password-based authentication (disable_password_authentication = false).
        * Leverage an Ubuntu Server 22.04 LTS image (Canonical publisher).

#### Public IP Integration
Fetch an existing Public IP resource using Terraform's data source (data.azurerm_public_ip.vm_public_ip) and attach it to the NIC.

#### Output Variables
* resource_group_name (type: string) - Displays the name of the resource group in uppercase (upper() function).
* vm_size_upper (type: string) - Displays the virtual machine size in uppercase.
* network_interface_id (type: string) - Displays the ID of the network interface in lowercase (lower() function).
* vm_public_ip (type: string) - Displays the public IP attached to the virtual machine.
* virtual_machine_id (type: string) - Displays the Linux virtual machine's ID with slashes replaced by dashes for readability (replace() function).

#### Validation & Cleanup
* Validate by listing resources in Azure.
* Ensure all resources can be destroyed cleanly.
