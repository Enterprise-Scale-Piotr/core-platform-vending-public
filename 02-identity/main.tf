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
resource "azuread_application" "sp_platform-dev-cd" {
  display_name = "sp_platform-dev-cd"
  owners       = [data.azuread_client_config.current.object_id]
  # Configure OIDC federation
  feature_tags {
    enterprise = true
    gallery    = true
  }
}

# Create Service Principal
resource "azuread_service_principal" "sp_platform-dev-cd" {
  client_id                    = azuread_application.sp_platform-dev-cd.client_id
  app_role_assignment_required = true
  owners                       = [data.azuread_client_config.current.object_id]
}

# Configure OIDC Federation Credentials
resource "azuread_application_federated_identity_credential" "wif-platform-dev-cd" {
  application_id = azuread_application.sp_platform-dev-cd.id
  display_name   = "wif-platform-dev-cd"
  description    = "GitHub OIDC federation wif-platform-dev-cd"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:WITT-AZURE-PLATFORM/atlz-platform:environment:platform-dev-cd" # Modify this according to your GitHub repo

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
