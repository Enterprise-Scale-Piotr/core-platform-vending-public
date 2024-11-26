terraform {
  required_version = "1.8.5"
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
  backend "azurerm" { ### Default Backend setting for local TF testing, will be overridden in CI/CD
    resource_group_name  = "rg-tfbackend-dev"
    storage_account_name = "statlztfstatedev"
    container_name       = "bootstrap"
    key                  = "03-iam-dev.tfstate"
  }
}

provider "azurerm" {
  features {}
}
provider "azapi" {
}

module "subscription_role_assignment" {
  source   = "Azure/lz-vending/azurerm"
  version  = "v2.1.1"
  for_each = { for idx, ra in local.subscription_role_assignments : "${ra.subscription_id}-${ra.principal_id}" => ra }

  subscription_id         = each.value.subscription_id
  location                = var.location
  role_assignment_enabled = true

  role_assignments = [
    {
      principal_id   = each.value.principal_id
      definition     = each.value.definition
      relative_scope = each.value.relative_scope
    }
  ]

  subscription_alias_enabled = false
  virtual_network_enabled    = false
  disable_telemetry          = true
}

resource "azurerm_role_assignment" "mg_role_assignment" {
  for_each = { for idx, sp_name in var.service_principal_names : sp_name =>
    data.terraform_remote_state.identity.outputs.service_principals_ids[sp_name].service_principal_object_id
  }

  scope                = data.azurerm_management_group.mg_scope.id
  role_definition_name = "Owner"
  principal_id         = each.value
}
