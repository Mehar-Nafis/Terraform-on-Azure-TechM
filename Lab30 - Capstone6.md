## Capstone 6: Incremental Application with -target in Terraform

#### Problem Statement

In this project, you are tasked with demonstrating the use of Terraform’s -target option to apply incremental changes to an AWS infrastructure. 
The scenario involves provisioning an S3 bucket and objects, applying changes to specific resources using the -target option, and managing the dependencies between resources. 
The task also includes restoring infrastructure consistency and cleaning up after the application.

#### Requirements

### Inputs
* bucket_prefix (type: string, default: "learning")
* object_count (type: number, default: 4)
* aws_region (type: string, default: "us-west-2")

### Resources
* Randomized S3 Bucket
    * Uses the random_pet resource to generate a unique name for the bucket.
    * An AWS S3 bucket will be created with lifecycle policies and versioning enabled.
* S3 Objects
    * Defines multiple S3 objects within the bucket, with random names generated using random_pet.
      
### Outputs
* bucket_name (type: string)
* bucket_arn (type: string)
* targeting_status (type: string)

### Validation & Cleanup:
* Verify the changes in Terraform’s plan and ensure the correct resources are targeted and updated.
* Confirm the existence and properties of the S3 bucket and objects in the AWS Management Console.
* Use terraform plan to ensure all resources are in sync and no further changes are needed.
* Destroy resources 

