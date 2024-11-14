# Output a copy of core Subscription IDs for Platform use
# by the core bootstrap module instance
output "subscription_id_management" {
  description = "Subscription ID for the \"management\" resources."
  value       = module.subscription_vending_management.subscription_id
}
output "subscription_id_identity" {
  description = "Subscription ID for the \"identity\" resources."
  value       = module.subscription_vending_identity.subscription_id
}
output "subscription_id_connectivity" {
  description = "Subscription ID for the \"connectivity\" resources."
  value       = module.subscription_vending_connectivity.subscription_id
}
