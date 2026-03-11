locals {
  # --- Naming convention: <tipo>-<proyecto>-<entorno> ---
  resource_group_name  = "rg-${var.project}-${var.environment}"
  storage_account_name = "st${var.project}${var.environment}"  # sin guiones (límite Azure)

  # --- Tags obligatorios en todos los recursos ---
  common_tags = {
    environment = var.environment
    project     = var.project
    managed_by  = "terraform"
    team        = "cloud-infrastructure"
  }
}
