provider "azurerm" {
  features {}
  subscription_id = "b70f2b66-b08e-4775-8273-89d81847a0c2"
}

provider "azuread" {
  # tenant_id = "238f0baa-db00-4292-bd40-4aff1fad9659"
}

# Random password generator for users
resource "random_password" "pwd" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

locals {
  users_data = csvdecode(file(".\\Users.csv"))
  
  # Mapping user data for user creation
  user_map = {
    for user in local.users_data :
      "${user.first_name}.${user.last_name}@meharnafisgmail.onmicrosoft.com" => {
        first_name = user.first_name
        last_name  = user.last_name
        department = user.department
        job_title  = user.job_title
      }
  }

  # Unique department list to create groups
  department_map = distinct([for user in local.users_data : user.department])
}

# Create a group for each department
resource "azuread_group" "department_group" {
  for_each = toset(local.department_map)
  
  display_name   = each.value
  mail_nickname  = each.value
  security_enabled = true
}

# Creating users
resource "azuread_user" "user" {
  for_each = local.user_map

  display_name        = "${each.value.first_name} ${each.value.last_name}"
  user_principal_name = each.key
  password            = random_password.pwd.result
  account_enabled     = true
  force_password_change = true
  depends_on          = [random_password.pwd]
}

resource "azuread_group_member" "member" {
  for_each = local.user_map
  
  group_object_id = basename(azuread_group.department_group[each.value.department].id)
  member_object_id = basename(azuread_user.user[each.key].id)
  depends_on = [ azuread_group.department_group, azuread_user.user ]
}


# Output the user credentials
output "user_creds" {
  value = [for index, user in azuread_user.user : {
    username = user.user_principal_name
    password = random_password.pwd.result
  }]
  sensitive = true
}
