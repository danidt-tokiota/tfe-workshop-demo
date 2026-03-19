locals {
  resource_group_name  = "rg-${var.project}-${var.environment}"
  virtual_network_name = "vnet-${var.project}-${var.environment}"

  common_tags = {
    environment = var.environment
    project     = var.project
    managed_by  = "terraform"
    team        = "cloud-infrastructure"
  }
}
