variable "name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "tags" {
  description = "Tags a aplicar al recurso"
  type        = map(string)
  default     = {}
}
