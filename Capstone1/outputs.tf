output "resource_group_name" {
  value       = "Resource Group Name: ${upper(data.azurerm_resource_group.RG.name)}"
  description = "The name of the created resource group (converted to uppercase)."
}

output "data_public_ip" {
  value       = "Pre-existing Public IP: ${data.azurerm_public_ip.vm_public_ip.ip_address}"
  description = "The IP address of the pre-existing public IP."
}

output "vm_public_ip" {
  value       = "Attached Public IP to VM: ${data.azurerm_public_ip.vm_public_ip.ip_address}"
  description = "Testing if the existing public IP is getting attached to the VM."
}

output "virtual_machine_id" {
  value       = "Linux VM ID: ${replace(azurerm_linux_virtual_machine.az-linux-vm.id, "/", "-")}"
  description = "The ID of the created Linux virtual machine (slashes replaced with dashes for readability)."
}

output "network_interface_id" {
  value       = "Network Interface ID: ${lower(azurerm_network_interface.az-net-int.id)}"
  description = "The ID of the created network interface (converted to lowercase)."
}

output "virtual_machine_size" {
  value       = "VM Size: ${title(var.vm_size)}"
  description = "The size of the virtual machine with title-cased formatting."
}
