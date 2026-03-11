variable "environment" {
  description = "Nombre del entorno (dev, pre, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "pre", "prod"], var.environment)
    error_message = "El entorno debe ser dev, pre o prod."
  }
}

variable "project" {
  description = "Nombre del proyecto"
  type        = string
  default     = "workshopdemo"
}

variable "location" {
  description = "Región de Azure donde se desplegará la infraestructura"
  type        = string
  default     = "West Europe"
}

variable "subscription_id" {
  description = "ID de la suscripción de Azure"
  type        = string
  sensitive   = true
}

variable "storage_account_tier" {
  description = "Tier de la cuenta de almacenamiento (Standard o Premium)"
  type        = string
  default     = "Standard"
}
