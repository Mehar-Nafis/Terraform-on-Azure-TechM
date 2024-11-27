variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "b70f2b66-b08e-4775-8273-89d81847a0c2"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "TF-Training"
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "Central India"
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
  default     = "az-network"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "internal"
}

variable "subnet_address_prefix" {
  description = "Subnet address prefix"
  type        = string
  default     = "10.0.2.0/24"
}

variable "nic_name" {
  description = "Network interface name"
  type        = string
  default     = "az-nic"
}

variable "vm_name" {
  description = "Virtual machine name"
  type        = string
  default     = "az-linux-vm1"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "ubuntu"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

variable "public_ip_name" {
  description = "Public IP name for the VM"
  type        = string
  default     = "VM-Capstone-IP"
}
