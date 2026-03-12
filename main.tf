terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = local.resource_group_name
  location = var.location
  tags     = local.common_tags
}

module "virtual_network" {
  source              = "./modules/virtual_network"
  name                = local.virtual_network_name
  resource_group_name = module.resource_group.name
  location            = var.location
  address_space       = var.vnet_address_space
  tags                = local.common_tags
}