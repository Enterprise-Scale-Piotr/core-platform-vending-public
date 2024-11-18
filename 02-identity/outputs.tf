# Output important values
/*
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
*/
output "service_principals_ids"{
  value = {
    for name in var.service_principal_names :
    name => {
      client_id = azuread_application.service_principals[name].client_id
      object_id = azuread_application.service_principals[name].object_id
      service_principal_object_id = azuread_service_principal.service_principals[name].object_id
    }
  }
}
