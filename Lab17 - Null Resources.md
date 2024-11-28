## Null Resources

Create a directory for the lab
```
cd ~/Labs && mkdir nullresource-lab && cd nullresource-lab 
```

### Task 1: Null Resource without Trigger

Create a main.tf file in your working directory.
```
vi main.tf
```
Add the following Terraform code
```
# Null Resource without Trigger
resource "null_resource" "trigger_example" {
#   triggers = {
#     time-stamp = timestamp() 
#   }

  provisioner "local-exec" {
    # command = "echo 'Trigger executed: ${self.triggers.unique_id}' > trigger_log.txt"
    command = "echo 'Trigger executed: ${timestamp()} ' > trigger_log.txt"
  }
}
```
Run the following command to initialize Terraform:
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
![image](https://github.com/user-attachments/assets/6624e500-b499-48a0-b110-f192be2e578d)

![image](https://github.com/user-attachments/assets/69e793d7-842a-40de-985a-d442e33d37e7)

Apply again and check.
```
terraform apply -auto-approve
```
![image](https://github.com/user-attachments/assets/0ffde68d-b992-45ed-9d10-168d4be97fe9)


### Task 2: Null Resource with Trigger
Uncomment the triggers. You main.tf should now look like below
```
# Null Resource with Trigger
resource "null_resource" "trigger_example" {
  triggers = {
    time-stamp = timestamp() 
  }

  provisioner "local-exec" {
    # command = "echo 'Trigger executed: ${self.triggers.unique_id}' > trigger_log.txt"
    command = "echo 'Trigger executed: ${timestamp()} ' > trigger_log.txt"
  }
}
```
Plan
```
terraform plan
```
Apply
```
terraform apply -auto-approve
```
![image](https://github.com/user-attachments/assets/8b4842fc-4edc-4a14-869c-dc094b4a8c3e)

Apply again and check.
```
terraform apply -auto-approve
```
![image](https://github.com/user-attachments/assets/285de0df-7924-48b3-90cd-8077d60c9151)


Clean Up
```
terraform destroy -auto-approve
```
```
cd ~/Labs && rm -rf nullresource-lab
```