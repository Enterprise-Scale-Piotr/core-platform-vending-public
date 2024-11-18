terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.9.0"
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
    key                  = "bootstrapidentity.tfstate"
  }
}

provider "azurerm" {
  features {}
}
provider "azapi" {
}

data "azuread_client_config" "current" {}

# Create Azure AD Application
resource "azuread_application" "service_principals" {
  #display_name = "sp_platform-dev-cd"
  for_each     = toset(var.service_principal_names)
  display_name = "sp-${each.value}"
  owners       = [data.azuread_client_config.current.object_id]
  # Configure OIDC federation
  feature_tags {
    enterprise = true
    gallery    = true
  }
}

# Create Service Principal
resource "azuread_service_principal" "service_principals" {
  #client_id                    = azuread_application.sp_platform-dev-cd.client_id
  for_each                     = toset(var.service_principal_names)
  client_id                    = azuread_application.service_principals[each.key].client_id
  app_role_assignment_required = true
  owners                       = [data.azuread_client_config.current.object_id]
}

# Configure OIDC Federation Credentials
resource "azuread_application_federated_identity_credential" "wif" {
  for_each       = toset(var.service_principal_names)
  application_id = azuread_application.service_principals[each.key].id
  display_name   = "wif-${each.value}"
  description    = "GitHub OIDC federation wif-${each.value}"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:WITT-AZURE-PLATFORM/atlz-platform:environment:${each.value}" # Modify this according to your GitHub repo

  # You can add multiple subject patterns like:
  # subject = "repo:your-org/your-repo:ref:refs/heads/main"
  # subject = "repo:your-org/your-repo:pull_request"
}
/*
module "role_assignment" {
  source                  = "Azure/lz-vending/azurerm"
  version                 = "v2.1.1"
  subscription_id         = "69115be7-e295-4cac-9c39-e17c2c34a237"
  location                = var.location
  role_assignment_enabled = true
  role_assignments = [
    {
      principal_id   = azuread_service_principal.sp_platform-dev-cd.object_id
      definition     = "Owner"
      relative_scope = ""
    }
  ]

  # Disable other features
  subscription_alias_enabled = false
  virtual_network_enabled    = false
  disable_telemetry          = true
}
*/
