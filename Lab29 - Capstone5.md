## Capstone 5: Migrate Terraform State to HCP Terraform

#### Problem Statement
You are tasked with migrating the local Terraform state file to HCP Terraform for improved security, collaboration, and state management. 
The migration should be seamless, without disrupting existing infrastructure or services. Post-migration, the Terraform workflow should utilize the HCP Terraform backend for state management.

#### Requirements

### Inputs
* organization_name (type: string) - Name of the HCP Terraform organization.
* workspace_name (type: string, default: "default-workspace") - Name of the workspace in HCP Terraform for storing the state.
* state_file_path (type: string, default: "./terraform.tfstate") - Path to the local Terraform state file to migrate.

### Resources
* HCP Terraform Workspace:
    * Create or use an existing workspace within the specified organization.
    * Ensure the workspace is empty (contains no existing state) before migration.
* HCP Terraform Integration:
    * Authenticate the Terraform CLI with HCP Terraform.
    * Configure the cloud block in the Terraform configuration for backend integration.
* Local Terraform State File:
    * Migrate the existing local state file to the configured HCP Terraform workspace.

### Outputs
* hcp_workspace_name (type: string) - Name of the HCP Terraform workspace.
* state_migration_status (type: string) - Status of the state migration.
* hcp_workspace_url (type: string) - URL of the HCP Terraform workspace for management.

### Validation & Cleanup
* Validate migration by verifying state consistency between local and HCP Terraform.
* Deploy a sample change to confirm the state functionality in HCP Terraform.
* Clean up resources and remove the local state file
* Optionally delete the HCP Terraform workspace if no longer required.
