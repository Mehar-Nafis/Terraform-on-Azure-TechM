## Provisioner

### Task 1: Using the local-exec Provisioner
Create a directory for the lab
```bash
cd ~/Labs && mkdir provisioner-lab && cd provisioner-lab && mkdir Task1 && cd Task1
```
Create a new file main.tf
```
vi main.tf
```
Add the following Terraform configuration to the file:
```
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}

resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "East US"
}

provisioner "local-exec" {
  command = "echo 'Resource group created successfully!' > creation_log.txt"
}
```
Initialize the Terraform configuration
```
terraform init
```
Plan
```
terraform plan
```
Apply the configuration
```
terraform apply -auto-approve
```
After the apply command finishes, check the current directory for the creation_log.txt file. 
![image](https://github.com/user-attachments/assets/d2ac6137-c0fd-468e-9d38-543f1ef0c3f4)


### Task 2: Using the remote-exec Provisioner
Create a directory for the lab
```bash
cd ~/provisioner-lab && mkdir Task2 && cd Task2
```
Create a new file main.tf
```
vi main.tf
```
Add the following Terraform configuration to the file
```
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}

resource "azurerm_resource_group" "RG" {
  name     = "tf-resource-grp"
  location = "Central India"
}

resource "azurerm_virtual_network" "az-net" {
  name                = "az-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
}

resource "azurerm_subnet" "az-subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.az-net.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create Public IP Address with Static allocation method
resource "azurerm_public_ip" "az-public-ip" {
  name                = "az-public-ip"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  allocation_method   = "Static"  
  sku                  = "Standard" 
}

resource "azurerm_network_interface" "az-net-int" {
  name                = "az-nic"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.az-public-ip.id  
  }
}

resource "azurerm_linux_virtual_machine" "az-linux-vm" {
  name                = "az-linux-vm1"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  size                = "Standard_D2s_v3"

  disable_password_authentication = false

  admin_username      = "ubuntu"
  admin_password      = "admin@1234"

  network_interface_ids = [
    azurerm_network_interface.az-net-int.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Remote Exec Provisioner Test' > /tmp/testfile.txt"
    ]

    connection {
      type     = "ssh"
      user     = "ubuntu"
      password = "admin@1234"
      host     = azurerm_linux_virtual_machine.az-linux-vm.public_ip_address        
    }
  } 
}

resource "azurerm_network_security_group" "nsg" {
  name                = "ssh-nsg"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
}

resource "azurerm_network_security_rule" "allow_ssh" {
  resource_group_name = azurerm_resource_group.RG.name
  name                        = "allow-ssh"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "0.0.0.0/0"  # Adjust to restrict access, e.g., only your IP
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id        = azurerm_network_interface.az-net-int.id
  network_security_group_id   = azurerm_network_security_group.nsg.id
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.az-linux-vm.public_ip_address 
}

output "private_ip_address" {
  value = azurerm_network_interface.az-net-int.private_ip_address
}
```
Initialize the Terraform configuration
```
terraform init
```
Plan
```
terraform plan
```
Apply the configuration
```
terraform apply -auto-approve
```
After creating the VM, SSH into it and check for the file /tmp/testfile.txt
```
ssh ubuntu@<Public IP?
```
`Passowrd: admin@1234`
![image](https://github.com/user-attachments/assets/5ee9ce6c-89ca-43dc-9991-24edc05555eb)

```
cat /tmp/testfile.txt
```
![image](https://github.com/user-attachments/assets/77fc21f9-bbb3-4444-aae2-aa27c1232ec7)

```
exit
```
![image](https://github.com/user-attachments/assets/dfda476e-e8f9-431f-8e18-5e33cfc17ef8)


Clean Up
```
terraform destroy -auto-approve
```

### Task 3: Using the file Provisioner

Create a directory for the lab:
```
cd ~/provisioner-lab && mkdir Task3 && cd Task3
```
Create a simple local file to upload
```
echo "This is a test file" > local_file.txt
```
Create a new file main.tf
```
vi main.tf
```
Add the following Terraform configuration to the file
```
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"  #Replace with your subscription id
}

resource "azurerm_resource_group" "RG" {
  name     = "tf-resource-grp"
  location = "Central India"
}

resource "azurerm_virtual_network" "az-net" {
  name                = "az-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
}

resource "azurerm_subnet" "az-subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.az-net.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create Public IP Address with Static allocation method
resource "azurerm_public_ip" "az-public-ip" {
  name                = "az-public-ip"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  allocation_method   = "Static"  
  sku                  = "Standard" 
}

resource "azurerm_network_interface" "az-net-int" {
  name                = "az-nic"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.az-public-ip.id  
  }
}

resource "azurerm_linux_virtual_machine" "az-linux-vm" {
  name                = "az-linux-vm1"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  size                = "Standard_D2s_v3"

  disable_password_authentication = false

  admin_username      = "ubuntu"
  admin_password      = "admin@1234"

  network_interface_ids = [
    azurerm_network_interface.az-net-int.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

    provisioner "file" {
        source      = "local_file.txt"
        destination = "/home/ubuntu/remote_file.txt"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      password = "admin@1234"
      host     = azurerm_linux_virtual_machine.az-linux-vm.public_ip_address        
    }
  } 
}

resource "azurerm_network_security_group" "nsg" {
  name                = "ssh-nsg"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
}

resource "azurerm_network_security_rule" "allow_ssh" {
  resource_group_name = azurerm_resource_group.RG.name
  name                        = "allow-ssh"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "0.0.0.0/0"  # Adjust to restrict access, e.g., only your IP
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id        = azurerm_network_interface.az-net-int.id
  network_security_group_id   = azurerm_network_security_group.nsg.id
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.az-linux-vm.public_ip_address 
}

output "private_ip_address" {
  value = azurerm_network_interface.az-net-int.private_ip_address
}
```
Initialize the Terraform configuration:
```
terraform init
```
Plan
```
terraform plan
```
Apply the configuration
```
terraform apply
```
![image](https://github.com/user-attachments/assets/a1dbc790-d9ee-4355-87ef-a551f437aaa2)

After creating the VM, SSH into it and check for the file /home/ubuntu/remote_file.txt
```
ssh ubuntu@<Public IP>
```
`Passowrd: admin@1234`
![image](https://github.com/user-attachments/assets/e0126f3f-075e-4926-b3f5-3f7c9639e541)

```
cat /home/ubuntu/remote_file.txt
```
![image](https://github.com/user-attachments/assets/c980eaa9-4531-4347-9a90-32eadf87b8a8)

```
exit
```

Clean Up
```
terraform destroy -auto-approve
```
```
cd ~/Labs && rm -rf provisioner-lab
```
