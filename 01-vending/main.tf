terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.9.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-platform-tfstate-dev"
    storage_account_name = "staplatformtfstatedev"
    container_name       = "bootstrap"
    key                  = "bootstrapvending.tfstate"
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
  subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/${var.billing_account_name}/billingProfiles/${var.billing_profile_name}/invoiceSections/${var.invoice_section_name}"
  subscription_display_name  = "${var.mg_id}-management"
  subscription_alias_name    = "${var.mg_id}-management"
  subscription_workload      = var.workload_type
}

module "subscription_vending_identity" {
  source   = "Azure/lz-vending/azurerm"
  version  = "~> 4.1.5"
  location = var.location
  # subscription variables
  subscription_alias_enabled = true
  subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/${var.billing_account_name}/billingProfiles/${var.billing_profile_name}/invoiceSections/${var.invoice_section_name}"
  subscription_display_name  = "${var.mg_id}-identity"
  subscription_alias_name    = "${var.mg_id}-identity"
  subscription_workload      = var.workload_type
}

module "subscription_vending_connectivity" {
  source   = "Azure/lz-vending/azurerm"
  version  = "~> 4.1.5"
  location = var.location
  # subscription variables
  subscription_alias_enabled = true
  subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/${var.billing_account_name}/billingProfiles/${var.billing_profile_name}/invoiceSections/${var.invoice_section_name}"
  subscription_display_name  = "${var.mg_id}-connectivity"
  subscription_alias_name    = "${var.mg_id}-connectivity"
  subscription_workload      = var.workload_type
}
