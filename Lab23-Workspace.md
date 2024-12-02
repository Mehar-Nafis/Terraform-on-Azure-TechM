## Workspace

### Create the Configuration File
```
cd ~ && mkdir workspace-lab && cd workspace-lab
```
Now Create File configuration file main.tf.
```
vi main.tf
```
```
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2" ## Update subscription_id with yours
}

resource "azurerm_resource_group" "RG" {
  name     = "tf-resource-grp"
  location = "East US"
}
```
Initialize Terraform in your working directory.
```
terraform init
```
Create a new workspace (e.g., dev) and switch to it.
```
terraform workspace new dev
```
Apply the Terraform configuration to create resources in the dev workspace.
```
terraform apply
```
Create another workspace (e.g., prod) and switch to it.
```
terraform workspace new prod
```
Apply the Terraform configuration to create resources in the prod workspace.
```
terraform apply
```
To Switch back to the dev workspace to manage resources in that environment.
```
terraform workspace select dev
```
To display the name of the currently selected workspace.
```
terraform workspace show
```
To list all available workspaces.
```
terraform workspace list
```
To Delete the dev workspace (make sure you are not currently in the dev workspace and you have execute the `terraform destroy` command to delete the resources created in that workspace).
```
terraform workspace select default  # Switch to another workspace first
```
```
terraform workspace delete dev
```
