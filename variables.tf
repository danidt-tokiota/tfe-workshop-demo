variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "pre", "prod"], var.environment)
    error_message = "El entorno debe ser dev, pre o prod."
  }
}

variable "project" {
  type    = string
  default = "workshopdemo"
}

variable "location" {
  type    = string
  default = "northeurope"
}

variable "subscription_id" {
  type      = string
  sensitive = true
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}