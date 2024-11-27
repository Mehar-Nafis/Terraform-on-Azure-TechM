## Meta Argument: LifeCycle

Create a Directory for Your Terraform Files
```
cd ~/Labs && mkdir lifecycle-lab && cd lifecycle-lab
```
Create a main.tf File
```
vi main.tf
```
In main.tf, add the following to define the Azure provider:
```
# Azure Provider for East US
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}

resource "azurerm_resource_group" "lifecycle-group" {
  name     = "lifecycle-group"
  location = "East US"
}

resource "azurerm_storage_account" "lifecyclegroupstorage" {
  name                     = "lifecyclegroupstorage"
  resource_group_name      = azurerm_resource_group.lifecycle-group.name
  location                 = azurerm_resource_group.lifecycle-group.location
  account_tier              = "Standard"
  account_replication_type = "LRS"

  # Uncomment one at a time to see the effect of each lifecycle argument
  lifecycle {
  #  create_before_destroy = true
  #  prevent_destroy = true
  #  ignore_changes = [name]
     replace_triggered_by = [azurerm_storage_account.triggeringresource.name]
  }

}

resource "azurerm_storage_account" "triggeringresource" {
  name                     = "triggeringresource"
  resource_group_name      = azurerm_resource_group.lifecycle-group.name
  location                 = azurerm_resource_group.lifecycle-group.location
  account_tier              = "Standard"
  account_replication_type = "LRS"
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

### Task 1: Create before Destroy

Now edit the main.tf file and change the name of the Storage Account to `lifecyclegroupstorage1` and apply the changes
```
terraform apply -auto-approve
```
Notice that first, the destroy is triggered, and then the creation
![image](https://github.com/user-attachments/assets/b0d0d237-8973-4a82-b95a-1fdbaf352635)


Now uncomment the lifecycle rule `create_before_destroy` and also change the name back to `lifecyclegroupstorage` and Apply again
```
terraform apply -auto-approve
```
Notice that first, the create is triggered, and then the destroy
![image](https://github.com/user-attachments/assets/e026701e-af1a-4e75-8ef4-74147b11503d)


### Task 2 : Prevent Destroy
Comment out the `create_before_destroy` and uncomment `prevent_destroy`
Now try and destory the resources.
```
terraform destroy -auto-approve
```
Notice, Terraform will not destroy this resource, even when you run terraform destroy. Any attempt to destroy it will result in an error.
![image](https://github.com/user-attachments/assets/6768758c-05cb-4a6b-872a-1244b9534f3e)


### Task 3: Ignore Changes
Now edit the main.tf file and 
* Change the name of the Storage Account to `lifecyclegroupstorage2`
* Uncomment the `ignore_chnages`
* Comment `prevent_destroy`
Apply
```
terraform apply -auto-approve
```
Notice that no change will be done
![image](https://github.com/user-attachments/assets/a7d30435-89c8-44c3-9f5d-4e2ef837d1c8)

### Task 4: Replace Triggered By
Now edit the main.tf file and 
* Change the name of the Storage Account from `triggeringresource` to `triggeringresource1`
* Coomment the `ignore_chnages`
* Uncomment `replace_triggered_by`
Apply
```
terraform apply -auto-approve
```
Notice that although we have made no changes to the `lifecyclegroupstorage` storage account but it is also being destoryed and recreated.
![image](https://github.com/user-attachments/assets/5e9318b8-7160-42f1-9f34-db9d358b3308)

Cleanup
```
terraform destory -auto-approve
```
```
cd ~/Labs && rm -rf lifecycle-lab
```
