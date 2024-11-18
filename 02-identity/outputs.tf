# Output important values
output "application_client_id" {
  value       = azuread_application.sp_platform-dev-cd.client_id
  description = "The Client ID of the Application"
}

output "application_object_id" {
  value       = azuread_application.sp_platform-dev-cd.object_id
  description = "The Object ID of the Application"
}

output "service_principal_object_id" {
  value       = azuread_service_principal.sp_platform-dev-cd.object_id
  description = "The Object ID of the Service Principal"
}
