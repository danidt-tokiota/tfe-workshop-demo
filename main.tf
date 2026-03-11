terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # En TFE el estado se gestiona automáticamente (remote backend)
  # No es necesario configurar backend aquí
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "resource_group" {
  source = "./modules/resource_group"

  name     = local.resource_group_name
  location = var.location
  tags     = local.common_tags
}

module "storage_account" {
  source = "./modules/storage_account"

  name                = local.storage_account_name
  resource_group_name = module.resource_group.name
  location            = var.location
  account_tier        = var.storage_account_tier
  tags                = local.common_tags
}
