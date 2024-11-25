##  Input Variables

### Task 1: Primitive Variables
#### Step 1: Create the configuration files
Create and Navigate to the Working Directory
```bash
cd ~/Labs && mkdir primitive_var_lab && cd primitive_var_lab
```
Create the main.tf file using vi or any text editor:
```bash
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

Create the vars.tf file:
```bash
vi vars.tf
```
Add the following content:
```hcl
variable "rg-name" {
  description = "setting up az resource group name"
  #default     = "test-resource-group"
}

variable "location" {
  description = "setting up location (region) for resources in az"
  #default     = "East US"
}

variable "sub-id" {
  #default = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}
```
Initialize
```
terraform init
```
#### Step 2: Plan the configuration file without passing any values
```
terraform plan
```
![image](https://github.com/user-attachments/assets/f8050872-aa3c-44f7-a336-617f82cb7e8e)

#### Step 3:  Plan using the default values
Now go and uncomment all the defaults in the vars.tf
```
vi vars.tf
```
Uncomment 
* `#default     = "test-resource-group"`
* `#default     = "East US"`
* `#default = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id`

Plan
```
terraform plan
```
Notice the values from the default are automatically being picked up
![image](https://github.com/user-attachments/assets/2aa1c799-1774-4cb9-a50a-bcef6fb4b68c)

### Step 4:  Using environment variables

Plan using environmental variables.
```
export TF_VAR_location="Central US"
```
```
echo $TF_VAR_location
```
![image](https://github.com/user-attachments/assets/67e51262-3538-4338-945a-eeeac7aaf60f)


### Step 5:  Pass variables from the Variables file
Create terraform.tfvars File
```
vi terraform.tfvars
```
Add the following content
```
location = "Central India"
rg-name = "tfvar-resource-group"
```
Plan
```
terraform plan
```
![image](https://github.com/user-attachments/assets/1ea4cce5-a47b-4c2c-b564-76ea947d7a15)

#### Step 6:  Plan by passing the values of the variables from the command line
Plan the configuration with custom variable values from the command line
```
terraform plan -var "rg-name=var-resource-group-2" -var "location=West US"
```
Notice the values passed from the command line override the defaults
![image](https://github.com/user-attachments/assets/0560a4e7-a69f-471e-b9cd-83e104e8990b)

### Step 7: Clean up
Clean up your resources if created
```hcl
terraform destroy -auto-approve
```
```bash
cd ~/Labs && rm -rf primitive_var_lab
```




