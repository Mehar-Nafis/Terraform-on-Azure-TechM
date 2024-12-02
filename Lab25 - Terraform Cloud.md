## Terraform Cloud
 
### Task 1: Create a new repo in Github

* Sign in in Github
* Click on New
* In the repository name: Enter "Terraform-Cloud"
* Click on Private
* Click on Create Repository
* Click on creating a new file
* Name your file vars.tf
* Add the following code
```
variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}
```
* Click on commit the new file.
* Add another file by clicking on add file dropdown and select create new file. 
* Name the file as rg.tf, Insert the below contents and commit the file. 
```
resource "azurerm_resource_group" "RG" {
  name     = "Azure_Tf_Resource-_Group"
  location = "East US"
}
```
* Click on commit the new file.
* Add another file by clicking on add file dropdown and select create new file. 
* Name the file as provider.tf, Insert the below contents and commit the file. 
```
 provider "azurerm" {
  features {}

  skip_provider_registration = "true"

  # Connection to Azure
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
}
```
### Task 2:Authorizing Terraform Cloud to write over Azure

#### Create an Azure Active Directory App Registration:
* Navigate to the Azure portal at https://portal.azure.com.
* Search for "Azure Active Directory" and select "App registrations".
* Click "New registration".
* Give the app a name, select "Accounts in this organizational directory only", and click "Register".
#### Obtain Client ID, Tenant ID, and Subscription ID:
* After creating the app, navigate to "Overview".
* Copy the "Application (client) ID" (this is the client_id).
* Copy the "Directory (tenant) ID" (this is the tenant_id).
* Search for "Subscriptions" in the Azure portal.
* Select your subscription and copy the "Subscription ID".
#### Create a Client Secret:
* In the "App registrations" page, select your app.
* Go to "Certificates & secrets".
* Click "New client secret".
* Add a description and choose an expiry date.
* Click "Add".
* Copy the "Value" of the client secret (this is the client_secret). Remember to save this somewhere secure, as you won't be able to access it later.



### Task 3: Create a Terraform Cloud Account

* Create a Terraform Cloud Account and Login
```
https://app.terraform.io/app
```


### Task 4: Create a new workspace

* Create a new organization
* Click on create a new workspace
* In tab 1, Select VCS (Version Control System) 
* In tab 2, select Github
* Once you click Github.com, a new window will popup. Sign into your GitHub account from there. Perform the verification and install Terraform on Git. 
* Now, we have the GitHub account connected with Terraform cloud. In tab 3 choose the repository where Terraform configuration is present, in this case, its Terraform-Cloud.
* In tab 4, Provide the name for the workspace of  your own choice and click the Create Workspace button. Once the workspace is created, you will see a success message in a popup. 



### Task 5: Add Azure Variables to Workspace:
* Now on the terraform cloud graphics, Navigate to your workspace's "Variables" section.
* Click on add variable and provide the following details(created in Task 2). Make sure you enable the sensitive check box. 
   * ARM_CLIENT_ID with the client_id value.
   * ARM_CLIENT_SECRET with the client_secret value (**mark as "sensitive"**).
   * ARM_TENANT_ID with the tenant_id value.
   * ARM_SUBSCRIPTION_ID with the subscription_id value.


### Task 6: Plan and Apply the changes 

* Now Click on New Run and choose the option plan and apply
* Once Plan is successful, scroll down a bit, and it will wait for the confirmation/approval to apply the changes. Click on¯Confirm & Apply 
* Provide a message in the textbox and click on Confirm Plan 
* You will see that the terraform apply is happening. 
* Once the apply is complete, check the Azure portal to ensure the resource group (or other deployed resources) has been created.




