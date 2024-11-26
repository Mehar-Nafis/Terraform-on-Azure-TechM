## Capstone

### Problem Statement
As part of a cloud infrastructure team, you are tasked with automating the deployment of a scalable and secure Linux virtual machine on Microsoft Azure. The goal is to create a reusable and modular Terraform configuration that incorporates specific input variables (with clearly defined data types and default values), and specific output variables and utilizes Terraform functions to manipulate outputs.

### Requirements:
#### Resource Group & VNet
* Input variables: resource_group_name (string), vnet_address_space (list(string)), and subnet_address_prefix (string).
* Create a Resource Group, VNet, and Subnet using these inputs.

#### NIC & VM:
* Deploy a NIC linked to the Subnet.
* Configure the Linux VM with:
    * Inputs: vm_name, vm_size (default: Standard_B2s), admin_username, and admin_password (all string types).
    * Password authentication enabled.
    * Public IP Integration:

#### Fetch an existing Public IP via Terraform's data source and attach it to the VM.

#### Output variables
* resource_group_name (string)
* vm_size_upper (string, uses upper() function)
* nic_id (string)
* vm_public_ip (string).

#### Validation & Cleanup
* Validate by listing resources in Azure.
* Ensure all resources can be destroyed cleanly.
