output "resource_group_name" {
  value = module.resource_group.name
}

output "virtual_network_name" {
  value = module.virtual_network.name
}

output "virtual_network_address_space" {
  value = module.virtual_network.address_space
}