terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.9.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG-Managment-PC"
    storage_account_name = "sapcterraformstate001"
    container_name       = "subscriptionsvendingstate"
    key                  = "bootstrap.tfstate"
  }
}

provider "azurerm" {
  features {}
}
module "subscription_vending_management" {
  source   = "Azure/lz-vending/azurerm"
  version  = "~> 4.1.5"
  location = var.location

  # subscription variables
  subscription_alias_enabled = true
  subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/a1aa45db-c0c7-5775-bb03-ba7bfb319d1a:d763d306-828a-4212-9ebc-578646584b66_2019-05-31/billingProfiles/WOLC-BFXU-BG7-PGB/invoiceSections/IX2Z-UCPZ-PJA-PGB"
  subscription_display_name  = "atlz-dev-management"
  subscription_alias_name    = "atlz-dev-management"
  subscription_workload      = var.workload_type
}

module "subscription_vending_identity" {
  source   = "Azure/lz-vending/azurerm"
  version  = "~> 4.1.5"
  location = var.location

  # subscription variables
  subscription_alias_enabled = true
  subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/a1aa45db-c0c7-5775-bb03-ba7bfb319d1a:d763d306-828a-4212-9ebc-578646584b66_2019-05-31/billingProfiles/WOLC-BFXU-BG7-PGB/invoiceSections/IX2Z-UCPZ-PJA-PGB"
  subscription_display_name  = "atlz-dev-identity"
  subscription_alias_name    = "atlz-dev-identity"
  subscription_workload      = var.workload_type
}

module "subscription_vending_connectivity" {
  source   = "Azure/lz-vending/azurerm"
  version  = "~> 4.1.5"
  location = var.location

  # subscription variables
  subscription_alias_enabled = true
  subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/a1aa45db-c0c7-5775-bb03-ba7bfb319d1a:d763d306-828a-4212-9ebc-578646584b66_2019-05-31/billingProfiles/WOLC-BFXU-BG7-PGB/invoiceSections/IX2Z-UCPZ-PJA-PGB"
  subscription_display_name  = "atlz-dev-connectivity"
  subscription_alias_name    = "atlz-dev-connectivity"
  subscription_workload      = var.workload_type
}
