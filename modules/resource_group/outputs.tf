output "name" {
  description = "Nombre del Resource Group"
  value       = azurerm_resource_group.this.name
}

output "id" {
  description = "ID del Resource Group"
  value       = azurerm_resource_group.this.id
}
