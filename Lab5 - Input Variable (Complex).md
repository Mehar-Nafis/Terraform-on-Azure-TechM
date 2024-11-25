##  Input Variable (Complex) - Map Variables


Create a directory and navigate to it:

bash
Copy code
cd ~/Labs && mkdir rg-map-lab && cd rg-map-lab
Create the variables file (variables.tf):

bash
Copy code
vi variables.tf
Press i to enter insert mode and add the following content:

hcl
Copy code
variable "resource_groups" {
  type = map(map(string))
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
Create the main configuration file (main.tf):

bash
Copy code
vi main.tf
Add the following content:

hcl
Copy code
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id                 = var.subscription_id
}

resource "azurerm_resource_group" "multi_rg" {
  for_each = var.resource_groups

  name     = each.value["name"]
  location = each.value["location"]
}
Initialize the Terraform working directory:

bash
Copy code
terraform init
Plan the execution:

bash
Copy code
terraform plan
Apply the changes to create the resource groups:

bash
Copy code
terraform apply
Verify the resource groups in Azure:

bash
Copy code
az group list -o table
Clean up resources to avoid charges:

bash
Copy code
terraform destroy
Navigate back and delete the folder:

bash
Copy code
cd ~/Labs && rm -rf rg-map-lab
Explanation
Map Variables: The resource_groups variable is a map of maps, where each key (rg1, rg2, rg3) represents a resource group with attributes like name and location.
Dynamic Resource Creation: The for_each argument dynamically creates one resource group for each entry in the map.
Flexible Regions: You can easily add or modify regions in the variables.tf file without changing the main configuration.

