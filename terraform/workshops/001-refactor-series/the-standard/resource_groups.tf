resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.name}-${var.env}"
  location = var.loc
}
