##  Output Variables

Create and Navigate to the Working Directory

```bash
cd ~/Labs && mkdir output_var_lab && cd output_var_lab
```
Create main.tf File
```
vi main.tf
```
Add the following content:
```hcl

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = var.sub-id  #Replace with your subscription id
}

resource "azurerm_resource_group" "RG" {
  name     = var.rg-name
  location = var.location
}
```
Create vars.tf for variable declarations:
```
vi vars.tf
```
Add the following content:
```hcl
variable "rg-name" {
  description = "setting up az resource group name"
  default     = "test-resource-group"
}

variable "location" {
  description = "setting up location (region) for resources in az"
  default     = "East US"
}

variable "sub-id" {
  default = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}
```
Create an output file to display the resource group ID
```
vi output-var.tf
```
Add the following content:
```hcl
output "rg-id" {
  value = azurerm_resource_group.RG.id
}
```

Run the initialization command
```
terraform init
```
Run the plan command to preview changes
```
terraform plan
```
Apply the configuration to create resources:
```
terraform apply -auto-approve
```
![image](https://github.com/user-attachments/assets/b9e6abe4-3ac6-4717-ac69-226ae1a06c21)

Run the following command to display the output:
```
terraform output rg-id
```
![image](https://github.com/user-attachments/assets/8866c946-7dcc-412c-952d-5d4ed27a4d2b)

Clean Up Resources
```
terraform destroy -auto-approve
```
```bash
cd ~/Labs && rm -rf output_var_lab
```
