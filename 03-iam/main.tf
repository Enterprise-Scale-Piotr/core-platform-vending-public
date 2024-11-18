terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.10.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.0.2"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.9.0" # Use the latest stable version
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-platform-tfstate-dev"
    storage_account_name = "staplatformtfstatedev"
    container_name       = "bootstrap"
    key                  = "bootstrapiam.tfstate"
  }
}

provider "azurerm" {
  features {}
}
provider "azapi" {
}

data "azuread_client_config" "current" {}

data "terraform_remote_state" "identity" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-platform-tfstate-dev"
    storage_account_name = "staplatformtfstatedev"
    container_name       = "bootstrap"
    key                  = "bootstrapidentity.tfstate"
  }
}

module "role_assignment" {
  source                  = "Azure/lz-vending/azurerm"
  version                 = "v2.1.1"
  subscription_id         = "69115be7-e295-4cac-9c39-e17c2c34a237"
  location                = var.location
  role_assignment_enabled = true
  role_assignments = [
    {
      #principal_id   = azuread_service_principal.sp_platform-dev-cd.object_id
      principal_id   = data.terraform_remote_state.identity.outputs.service_principal_object_id
      definition     = "Owner"
      relative_scope = ""
    }
  ]

  # Disable other features
  subscription_alias_enabled = false
  virtual_network_enabled    = false
  disable_telemetry          = true
}
