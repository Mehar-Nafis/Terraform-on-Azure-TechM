## Capstone

### Problem Statement
As part of a cloud infrastructure team, you are tasked with automating the deployment of a scalable and secure Linux virtual machine on Microsoft Azure. The goal is to create a reusable and modular Terraform configuration that incorporates specific input variables (with clearly defined data types and default values), specific output variables, and utilizes Terraform functions to manipulate outputs.

The configuration must meet the following requirements:

##### Resource Group and Virtual Network Setup:
* Create a new Azure Resource Group and Virtual Network with names as input variables of type string.
* Use an input variable of type list(string) for defining the Virtual Network's address space.
* Ensure the Virtual Network contains a subnet with an address prefix defined as an input variable of type string.

##### Network Interface and VM Deployment:
* Deploy a Network Interface (NIC) linked to the created subnet. The NIC name must be passed as an input variable of type string.
Configure a Linux Virtual Machine using the NIC with the following properties:
Admin credentials provided dynamically via input variables of type string (for username and password).
VM size set as an input variable of type string with default value Standard_B1s.
VM name passed as an input variable of type string.
Enable password authentication for administrative access.
Integration with Existing Public IP:
Fetch an existing Azure Public IP using Terraform's data source, referencing its name and resource group (both provided as input variables of type string).
Output the VM's public IP address using an output variable of type string.
Reusable and Modular Configuration:
Use input variables for the following:
Resource group name, virtual network name, VM name, and subnet name (string type).
VNet address space (list(string) type).
Subnet address prefix (string type).
Create output variables for:
Resource group name (string).
NIC ID (string).
VM size (string) displayed in uppercase using the upper() function.
Public IP address of the VM (string).
Validation and Cleanup:
Validate the deployment by listing resources and confirming VM creation in Azure using the Azure CLI.
Ensure the environment can be destroyed without leaving residual resources to minimize costs.
Additional Details for Input and Output Variables:
Input Variables:
resource_group_name (type: string) – Name of the resource group.
vnet_address_space (type: list(string)) – Address space for the virtual network.
subnet_address_prefix (type: string) – Address prefix for the subnet.
vm_size (type: string, default: Standard_B2s) – VM size.
admin_username (type: string) – Username for the VM admin.
admin_password (type: string, sensitive: true) – Password for the VM admin.
Output Variables:
resource_group_name (type: string) – Displays the resource group name.
vm_size_upper (type: string) – Outputs the VM size in uppercase using the upper() function.
nic_id (type: string) – Displays the NIC ID.
vm_public_ip (type: string) – Displays the public IP of the VM.
