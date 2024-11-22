## Terraform Setup

### Step 1: Create an Ubuntu Virtual Machine in Azure and Connect
1. **Log in to the Azure Portal**.
2. Navigate to **"Virtual machines"** and click **"Create"**.
3. Fill out the following fields:
   - **Resource Group**: Create a new one or use an existing one.
   - **Virtual Machine Name**: Choose a unique name.
   - **Region**: Select a region close to your location(eg: Central India)
   - **Image**: Select **Ubuntu Server 24.04 LTS**.
   - **Size**: Select a suitable VM size (e.g., D2s_v3).
   - **Authentication Type**: Use **SSH public key** or **password**.
4. **Networking**: Ensure the VM is accessible through SSH by adding inbound rules for port 22.
5. Click **"Review + create"**, then **"Create"**.
6. Connect to the VM.


### Step 2: Install Terraform and Azure CLI on the VM
Add the HashiCorp GPG key:
```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
```
Add the official HashiCorp Linux repository:
```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```
Update and install Terraform:
```
sudo apt update && sudo apt install terraform
```
Verify Terraform installation:
```
terraform version
```
Download and install Azure CLI
```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```
Verify Azure CLI installation:
```
az version
```
### Step 3: Authenticate with Azure
Run the Azure login command:
```
az login
```
A web browser has been opened at https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize. Please continue the login in the web browser. 
If no web browser is available or if the web browser fails to open, use the below command and enter the code printed on the terminal to authenticate.
```
az login --use-device-code
```
Verify authentication:
```
az group list -o table
```
List all VMs:
```
az vm list -o table
```

