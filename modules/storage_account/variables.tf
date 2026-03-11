variable "name" {
  description = "Nombre de la Storage Account (3-24 chars, solo minúsculas y números)"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group donde se creará"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "account_tier" {
  description = "Tier de la cuenta (Standard o Premium)"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Tipo de replicación (LRS, GRS, ZRS...)"
  type        = string
  default     = "LRS"
}

variable "tags" {
  description = "Tags a aplicar al recurso"
  type        = map(string)
  default     = {}
}
