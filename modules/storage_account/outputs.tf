output "name" {
  description = "Nombre de la Storage Account"
  value       = azurerm_storage_account.this.name
}

output "id" {
  description = "ID de la Storage Account"
  value       = azurerm_storage_account.this.id
}

output "primary_blob_endpoint" {
  description = "Endpoint primario de Blob Storage"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}
