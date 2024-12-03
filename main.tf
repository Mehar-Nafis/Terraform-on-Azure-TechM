provider "azurerm" {
  features {}
  subscription_id  = "beca198a-e100-4ec3-8bff-e2ef65025f9b"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
