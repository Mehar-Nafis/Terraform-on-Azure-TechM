* Ensure you have a HCP Organization and Workspace connected to Terraform CLI
* Authenticate with HCP Terraform:terraform login 
* Migrate the state file: To migrate your existing state file to HCP Terraform, you must reinitialize your configuration to update the backend.
```
terraform init
```
* Configure the HCP Terraform workspace
* Your configuration relies on an input variable. Navigate to the workspace's Variables page and create a new Terraform variable named name_length with a value of 5.
* After verifying that Terraform migrated your state to HCP Terraform, remove your local state file.
```
rm terraform.tfstate
```
* Trigger a new run. Terraform will propose replacing your resource to reflect the update to the name_length input variable.
```
terraform apply
```

