## Capstone 7: Troubleshooting Terraform Configuration Errors

#### Problem Statement:

You are tasked with troubleshooting and resolving errors in a Terraform configuration that provisions AWS EC2 instances, each associated with a unique security group. 
The configuration uses the for_each attribute to create multiple instances,
but errors are encountered due to incorrect handling of security group references and missing resource instance keys in outputs.
You will need to correct the configuration to properly manage the for_each error, fix output issues, and implement best practices for bug reporting.

#### Requirements:
* Correct the for_each expression in the aws_instance resource to use a map instead of a list.
* Fix the vpc_security_group_ids and tags attributes to apply the correct syntax for multiple resources.
* Implement the for expression in outputs.tf to capture and display the IDs, public IPs, and names of all created instances.
* Ensure that the Terraform configuration is valid and formatted.
* Apply the Terraform changes and confirm that the instances are provisioned correctly.
* Enable Terraform logging for debugging, and create an example bug report following Terraform's best practices for core and provider logs.
  
#### Inputs:
* Terraform configuration with AWS provider set up.
* AWS security groups (e.g., sg_ping, sg_8080).
* AWS AMI (e.g., Ubuntu AMI) for EC2 instance creation.
  
#### Resources:

* aws_instance.web_app: A resource that creates EC2 instances using for_each with security groups assigned dynamically.
* local.security_groups: A local value used to convert the security groups into a map type.
* outputs.tf: A file used to define outputs such as instance IDs, public IPs, and names.
* Terraform version 1.8.3 (or newer).
* AWS provider version 5.56.1 (or newer).

Outputs:

* instance_id: List of IDs for the created EC2 instances.
* instance_public_ip: List of public IP addresses of the created instances.
* instance_name: List of names (tags) for the created EC2 instances.
  
#### Validation & Cleanup:

* Use terraform validate to ensure that the configuration is correct and free of errors after making the changes.
* Use terraform fmt to format the Terraform configuration files correctly.
* Run terraform plan to check the proposed changes before applying them.
* Once the Terraform configuration has been successfully applied, clean up the resources using terraform destroy to remove the EC2 instances and security groups.
