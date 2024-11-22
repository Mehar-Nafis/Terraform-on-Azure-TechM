## Local File creation using Terraform

This guide will take you through all the steps needed to create, manage, verify, and clean up a local file resource using Terraform. This will help you become familiar with Terraform's fundamental commands and workflow.

### Step 1: Set Up the Working Directory and Create the Terraform Configuration File

Create a directory named  and navigate.
  ```bash
  mkdir ~/Labs && cd Labs && mkdir local-file-lab && cd local-file-lab
```
Create and open a new file named local-file.tf
```
vi local-file.tf
```
Enter "INSERT" mode in vi by pressing the i key.

Add the following content to the local-file.tf file:
```hcl
resource "local_file" "myfile" {
    filename = "/home/ubuntu/local-file-lab/test.txt"
    content  = "wel come to terraform"
}
```
Save and exit the file by pressing ESC, typing :wq!, and pressing Enter.

### Step 2: Run Terraform Commands
Initialize the Terraform working directory. The below command sets up the working directory by downloading the required provider plugins.
```
terraform init
```

Create an execution plan. This previews the changes that will be applied and ensures there are no errors in the configuration.
```
terraform plan
```

Apply the configuration to create the file
```
terraform apply
```
When prompted, type yes to confirm the changes. This will create the test.txt file with the specified content.

### Step 3: Verify the File Creation
Once Terraform has applied the configuration, you should verify that the file has been created and that its content matches what was specified.
Navigate to the /home/ubuntu directory and list the files
```bash
cd /home/ubuntu/local-file-lab && ls
```
Display the content of test.txt:
```
cat test.txt
```
You should see the output `wel come to terraform`

### Step 4: Clean Up Resources
Navigate back to the local-file-lab directory.
```
cd /home/ubuntu/local-file-lab
```
Destroy the Terraform-managed resources:
```
terraform destroy
```
When prompted, type yes to confirm. This command will delete the test.txt file.
Navigate back to the home directory:
```
cd ~/Labs
```
Remove the loacl-file-lab directory:
```
rm -rf local-file-lab
```
