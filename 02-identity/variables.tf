/*
variable "subscription_id_management" {
  type        = string
  description = "Subscription ID to use for \"management\" resources."
}

variable "subscription_id_identity" {
  type        = string
  description = "Subscription ID to use for \"identity\" resources."
}

variable "subscription_id_connectivity" {
  type        = string
  description = "Subscription ID to use for \"connectivity\" resources."
}
*/
variable "service_principal_names" {
  description = "List of service principal names to create"
  type        = list(string)
}
/*
variable "location" {
  default     = "westeurope"
  description = "Azure region where the Resource Group is created"
  type        = string
}

variable "billing_account_id" {
  description = "Id of the billing account"
  type        = string
}

variable "billing_profile_id" {
  description = "Id of the billing profile"
  type        = string
}

variable "invoice_section_id" {
  description = "Id of the invoice section"
  type        = string
}

#variable "billing_scope" {
#  description = "Billing Scope"
#  type        = string
#}
*/
