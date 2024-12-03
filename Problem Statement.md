## Capstone-2:  Azure Virtual Machine Scale Sets with Terraform

### Problem Statement
As part of a cloud infrastructure team, you are tasked with automating the deployment and management of a scalable, load-balanced Virtual Machine Scale Set (VMSS) on Microsoft Azure using Terraform. The solution must include autoscaling capabilities based on CPU utilization and provide reusable configurations for network infrastructure and virtual machines. The goal is to ensure high availability and efficient resource utilization while adhering to best practices.

### Requirements

#### Inputs
*	resource_group_name (type: string) - Name of the resource group.
*	location (type: string, default: "westus3") - Azure region for deployment.
*	vmss_name (type: string, default: "vmss-terraform") - Name of the Virtual Machine Scale Set.
*	instance_count (type: number, default: 3) - Initial number of VM instances in the scale set.
*	vm_size (type: string, default: "Standard_D2s_v4") - Size of the virtual machines.
*	admin_username (type: string, default: "azureuser") - Administrator username for the VMs.
*	admin_ssh_key (type: string) - Path to the SSH public key file for authentication.

#### Resources
1.	Setup the Network Infrastructure consisting of the below resources:
    * Virtual Network, Subnet, Network Security Group, and Load Balancer.
2.	Virtual Machine Scale Set:
    *	Configure azurerm_orchestrated_virtual_machine_scale_set with:
    *	OS: Ubuntu 22.04 LTS (Canonical publisher).
    *	Fault domain count: 1 (for zonal deployments).
    *	Zones: Enable deployment in specific availability zones.
    *	User Data Script: Base64-encoded script to configure VM instances.
3.	Autoscaling:
    *	Define autoscale rules using azurerm_monitor_autoscale_setting with:
    *	Scale-out: Add an instance when CPU usage exceeds 90%.
    *	Scale-in: Remove an instance when CPU usage drops below 10%.

#### Outputs
*	application_endpoint (type: string) - Displays the endpoint of the load balancer.
*	current_instance_count (type: number) - Displays the current number of instances in the scale set.
*	vmss_id (type: string) - The ID of the VMSS resource.
*	admin_ssh_key_base64 (type: string) - Base64-encoded SSH key (base64encode() function).

#### Validation & Cleanup
* Validate by listing resources in Azure.
* Access the application endpoint in a browser.
* Test autoscale by adjusting CPU load on the VMs.
* Verify scaling actions using az vm list after each scaling event.
* Ensure all resources can be destroyed cleanly.




