## Depends On

Create a directory for the lab
```
cd ~/Labs && mkdir dependson-lab && cd dependson-lab 
```
Create a new file main.tf
```
vi main.tf
```
Add the following Terraform configuration to the file:
```
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}

resource "null_resource" "custom_action" {
  provisioner "local-exec" {
    command = "echo 'Resource group created with the ID: ${azurerm_resource_group.example.id}' > rg_log.txt"
  }

  # depends_on = [azurerm_resource_group.example] # Explicit Dependency
}


resource "azurerm_resource_group" "example" {
  name     = "depends-on-rg"
  location = "East US"
}
```
Initialize
```
terraform init
```
Plan
```
terraform plan
```
Apply
```
terraform apply -auto-approve
```
The apply step will likely fail with an error, as Terraform cannot guarantee the resource group exists before the null resource executes.

Uncomment the depends_on line.
```
terraform apply -auto-approve
```
This time, the null resource will execute successfully after the resource group is created.



Clean Up: 
```
terraform destroy -auto-approve
```
```
cd ~/Labs && rm -rf dependson-lab
```
