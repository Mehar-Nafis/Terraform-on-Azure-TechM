* There are four potential types of issues that you could experience with Terraform: language, state, core, and provider errors. 

* Language errors: The primary interface for Terraform is the HashiCorp Configuration Language (HCL), a declarative configuration language.
  The Terraform core application interprets the configuration language. When Terraform encounters a syntax error in your configuration,
  it prints out the line numbers and an explanation of the error.
  
* State errors: The Terraform state file stores information on provisioned resources.
  It maps resources to your configuration and tracks all associated metadata. If state is out of sync, Terraform may destroy or change your existing resources.
  After you rule out configuration errors, review your state. Ensure your configuration is in sync by refreshing, importing, or replacing resources.
  
* Core errors: The Terraform core application contains all the logic for operations.
  It interprets your configuration, manages your state file, constructs the resource dependency graph, and communicates with provider plugins.
 Errors produced at this level may be a bug. Later in this tutorial, you will learn best practices for opening a GitHub issue for the core development team.

* Provider errors: The provider plugins handle authentication, API calls, and mapping resources to services.
  Later in this tutorial, you will learn best practices for opening a GitHub issue for the provider development team.
