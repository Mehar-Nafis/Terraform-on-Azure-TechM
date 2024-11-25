##  Input Variable (Complex) - Map Variables

Create a directory and navigate to it
```
cd ~/Labs && mkdir rg-map-lab && cd rg-map-lab
```
Create the variables file (variables.tf)
```
vi variables.tf
```
Press i to enter insert mode and add the following content
```hcl
variable "resource_groups" {
  # type = map(map(string))
  default = {
    rg1 = {
      name     = "tf-rg-us-east"
      location = "East US"
    }
    rg2 = {
      name     = "tf-rg-uk-south"
      location = "UK South"
    }
    rg3 = {
      name     = "tf-rg-west-europe"
      location = "West Europe"
    }
  }
}

variable "subscription_id" {
  type    = string
  default = "b70f2b66-b08e-4775-8273-89d81847a0c2" # Update with your subscription ID
}
```
Create the main configuration file (main.tf)
```
vi main.tf
```
Add the following content
```hcl
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id                 = var.subscription_id
}

resource "azurerm_resource_group" "multi_rg" {
  name     = var.resource_groups["rg1"]["name"]
  location = var.resource_groups["rg1"]["location"]
}
```
Initialize the Terraform working directory:
```
terraform init
```
Plan the execution:
```
terraform plan
```
Apply the changes to create the resource groups:
```
terraform apply -auto-approve
```
Verify the resource groups in Azure
```
az group list -o table
```
Clean up resources to avoid charges:
```
terraform destroy
```
Navigate back and delete the folder:
```
cd ~/Labs && rm -rf rg-map-lab
```
