resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.workload_name}-${var.environment}"
  location = var.location
}
