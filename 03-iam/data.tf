#data "azuread_client_config" "current" {}
data "azurerm_management_group" "mg_scope" {
  name = var.mg_id
}
data "terraform_remote_state" "vending" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-tfbackend-dev"
    storage_account_name = "statlztfstatedev"
    container_name       = "bootstrap"
    key                  = "01-vending-dev.tfstate"
  }
}
data "terraform_remote_state" "identity" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-tfbackend-dev"
    storage_account_name = "statlztfstatedev"
    container_name       = "bootstrap"
    key                  = "02-identity-dev.tfstate"
  }
}
