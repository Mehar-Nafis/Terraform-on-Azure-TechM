## Capstone 4 - Configuring Entra ID Users and Groups with Terraform

### Problem Statement
You are tasked with managing users and groups in an Azure Entra ID (formerly Azure Active Directory) tenant using Terraform. 
The goal is to create a system that provisions users from a CSV file, assigns them to specific groups based on attributes such as department and job title, and adheres to best practices in infrastructure as code. The solution must be repeatable, secure, and scalable.

#### Requirements

### Inputs
* csv_file_path (type: string) - Path to the CSV file containing user details.
* azuread_version (type: string, default: "2.41.0") - Version of the AzureAD provider.
* resource_suffix_length (type: number, default: 2) - Length of the random suffix for resource uniqueness.
  
### Outputs
* user_ids (type: list) - List of IDs of the created users.
* group_ids (type: list) - List of IDs of the created groups.
* state_summary (type: map) - Summary of created Entra ID resources.

### Resources

* AzureAD Provider
    * Authenticate using Azure CLI.
    * Manage user and group provisioning.

* Users
    * Provision users based on the CSV file.
    * Assign initial passwords and configure password change on the first login.
    * Use random suffixes for unique principal names.

* Groups
    * Create groups based on job titles and departments.
    * Assign users to appropriate groups using conditions.

### Validation & Cleanup
* Check if users are created correctly using Terraform outputs and Azure CLI.
* Verify group memberships based on user attributes.
* Use terraform destroy to remove all created resources
