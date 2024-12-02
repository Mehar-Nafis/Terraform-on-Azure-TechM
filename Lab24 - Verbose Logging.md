## Verbose Logging
Terraform's logging can be controlled with the TF_LOG and TF_LOG_PATH environment variables.
  * `TF_LOG`: Sets the logging level (TRACE, DEBUG, INFO, WARN, ERROR).
  * `TF_LOG_PATH`: Specifies the file path where logs will be stored.

Create a working directory for the lab
```
mkdir verbose-logging && cd verbose-logging
```
Initialize a new Terraform configuration file (main.tf): Create a main.tf file with the following basic configuration:
```
vi main.tf
```
```hcl

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
This configuration uses the local_file resource to create a file named hello.txt in the current directory with the specified content.

Set the TF_LOG environment variable to DEBUG:
```
export TF_LOG=DEBUG
```
Save logs to a file by setting the TF_LOG_PATH environment variable:
```
export TF_LOG_PATH="./terraform.log"
```
Initialize the Terraform configuration:
```
terraform init
```
Apply the Terraform configuration:
```
terraform apply -auto-approve
```
The logs will show detailed information on how Terraform processes the local_file resource.

Check that the hello.txt file was created in the current directory:
```
cat hello.txt
```
You should see the content: Hello, Terraform with verbose logging!

If you used the TF_LOG_PATH, open the terraform.log file to review the logs:
```
less terraform.log
```
Try setting TF_LOG to other levels (TRACE, INFO, WARN, ERROR) and re-run the terraform apply command:
```
export TF_LOG=TRACE
```
```
terraform apply -auto-approve
```
Observe how the verbosity of the log output changes with different log levels.

Unset the TF_LOG and TF_LOG_PATH environment variables:
```
unset TF_LOG
unset TF_LOG_PATH
```

Destroy the created resources:
```
terraform destroy -auto-approve
```
Delete the generated files and working directory:
```
cd ~ && rm -rf verbose-logging
```
