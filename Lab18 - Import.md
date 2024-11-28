## Import

Before performing the Terraform import lab, you’ll need to create a resource (e.g., an Azure Virtual Machine) manually in the Azure portal to obtain the necessary information like the VM ID, resource group, and other properties.

Once the resource is running, you can follow the steps below to import the infrastructure.

Create a directory and navigate to it
```
cd ~/Labs && mkdir azure_import_lab && cd azure_import_lab
```
Create a import.tf file
```
vi import.tf
```
Press "INSERT" to enter the editing mode in vi and add the following content:
```
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}

resource "azurerm_virtual_machine" "test_vm" {
  name                = "Import-VM"
  location            = "centralindia"
  resource_group_name = "existing-resource-group"
  vm_size             = "Standard_D2s_v3"
  

  # OS Disk Configuration
  storage_os_disk {
    name          = "Import-VM_disk1_8b771606463d437085faf798bc68cd5e"
    create_option = "FromImage"
    # Not required when importing,b ut may be required before final plan if any mismatch
    # caching       = "ReadWrite"   
    # disk_size_gb  = 30            
  }

  # Network Interface
  network_interface_ids = [
    "/subscriptions/b70f2b66-b08e-4775-8273-89d81847a0c2/resourceGroups/existing-resource-group/providers/Microsoft.Network/networkInterfaces/import-vm255_z1"
  ]

# ### Not required when importing,but may be required before final plan if any mismatch. Uncomment if required
# # Image Reference
#   storage_image_reference {
#     publisher = "canonical"
#     offer     = "ubuntu-24_04-lts"
#     sku       = "server"
#     version   = "latest"
#   }

# # OS Profile (Linux-specific configurations)
#   os_profile {
#     computer_name  = "Import-VM"
#     admin_username = "azureuser"
#     admin_password = ""  
#      }

#   os_profile_linux_config {
#       disable_password_authentication = true
#       ssh_keys {
#         path     = "/home/azureuser/.ssh/authorized_keys"
#         key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvyx81ZIxbJjdm92ofnsCdXlbfT/6XDN5/o+DsuS0h8gvpIIf0p8plFS2QCVeXRWY+kOYeQZkV1cpR1LSy//UxQ+agEcwR7JbgX8V8S7dzdwffsyFPK0eCPpAFrvxUj/K8OYNYeGrHCmcaJ/lsyIafUbYWMWzwQ8NbHmK93tIDx9DzVfD1BpkSwMX9sE5Be3+s7S9sqQQ3Lf3ho4t5iue1dbZPCj16dPC3OS/iVcWCv4q8BRJFEntb3bb3M/clfut0ssWrNMDy4807nX7aWFbGCXjYoa1VywssnivcdjuqRXjoY+4mLshrRmT+RB6rgb9YfRrUFFK+ydzLfqB+rRSEjKbXP/2uSIyN86PDKS/rbecy9XFzaQZRlR2O3y3LSN+Xn+yVAPZk79ZJmNYQXRWwV6i5gn920onv1z47KgoZMFSZzD52hjlF6tNCpZqy84CPUa4xWK1cxT0xHPxe2pvWe6zXzHZB/Nouddh97cNwiDDwpvbzDl1mPT8cvz5fiX0= generated-by-azure"
#       }
#     }   


# # Availability Zone
#   zones = ["1"]                  

#   boot_diagnostics {              
#     storage_uri = ""
#     enabled = true
#   }

}
```

Press ESC, then type :wq! and hit Enter to save and quit vi.

Initialize Terraform
```
terraform init
```
Plan the Configuration
```
terraform plan
```
Execute the terraform import command to import the Azure resource (Virtual Machine) into your Terraform state file, by replacing the placeholders.
```
terraform import azurerm_virtual_machine.test_vm /subscriptions/<subscription_id>/resourceGroups/<resource_group_name>/providers/Microsoft.Compute/virtualMachines/<vm_name>
```
`terraform import azurerm_virtual_machine.test_vm "/subscriptions/b70f2b66-b08e-4775-8273-89d81847a0c2/resourceGroups/existing-resource-group/providers/Microsoft.Compute/virtualMachines/Import-VM"`

![image](https://github.com/user-attachments/assets/e85f7083-cf10-4949-8e2f-5b6ffd469870)

Run the following command to verify that the resource has been successfully imported and is now part of your Terraform state file
```
terraform state list
```

Since the resource has already been created manually, running the terraform plan will not modify it unless there are changes in the configuration file. 
```
terraform plan
```

You can now destroy the imported resource from Terraform (be careful with this operation as it will delete the VM):
```
terraform destroy
```

Once the lab is complete, clean up by removing the directory:
```
cd ~/Labs && rm -rf azure_import_lab
```
