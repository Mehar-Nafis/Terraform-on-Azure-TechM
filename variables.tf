variable "location" {
  description = "Azure Region"
  default     = "Central India"
}

variable "vm_size" {
  description = "Size of the Virtual Machine"
  default     = "Standard_D2_v2"
}

variable "vpc_cidr" {
  description = "CIDR block for the Virtual Network"
  default     = "10.0.0.0/16"
}

variable "min_instances" {
  description = "Minimum number of instances"
  default     = 1
}

variable "max_instances" {
  description = "Maximum number of instances"
  default     = 3
}
variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
  default     = "terraform-vmss"
}
