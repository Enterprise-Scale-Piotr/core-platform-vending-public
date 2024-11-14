variable "location" {
  default     = "westeurope"
  description = "Azure region where the Resource Group is created"
  type        = string
}

variable "billing_account_name" {
  default     = "a1aa45db-c0c7-5775-bb03-ba7bfb319d1a:d763d306-828a-4212-9ebc-578646584b66_2019-05-31"
  description = "Name of the billing account"
  type        = string
}

variable "billing_profile_name" {
  default     = "WOLC-BFXU-BG7-PGB"
  description = "Name of the billing profile"
  type        = string
}

variable "invoice_section_name" {
  default     = "IX2Z-UCPZ-PJA-PGB"
  description = "Name of the invoice section"
  type        = string
}

variable "mg_id" {
  default     = "atlz-dev"
  description = "Id of Management Group"
  type        = string
}

variable "workload_type" {
  default     = "Production"
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
