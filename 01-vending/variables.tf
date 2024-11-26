variable "location" {
  default     = "westeurope"
  description = "Azure region where the Resource Group is created"
  type        = string
}

variable "billing_account_name" {
  description = "Name of the billing account"
  type        = string
}

variable "billing_profile_name" {
  description = "Name of the billing profile"
  type        = string
}

variable "invoice_section_name" {
  description = "Name of the invoice section"
  type        = string
}

variable "mg_id" {
  default     = "atlz-dev"
  description = "Id of L1 Management Group"
  type        = string
}

variable "workload_type" {
  default     = "DevTest"
  description = "Production or DevTest"
  type        = string
}
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
