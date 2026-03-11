output "resource_group_name" {
  description = "Nombre del Resource Group creado"
  value       = module.resource_group.name
}

output "storage_account_name" {
  description = "Nombre de la Storage Account creada"
  value       = module.storage_account.name
}

output "storage_account_id" {
  description = "ID de la Storage Account"
  value       = module.storage_account.id
}
