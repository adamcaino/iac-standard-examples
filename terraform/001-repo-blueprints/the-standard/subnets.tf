resource "azurerm_subnet" "subnet_windows" {
  name                 = "snet-win-${var.name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_main_network_prod_uat.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet_linux" {
  name                 = "snet-lin-${var.name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_main_network_prod_uat.name
  address_prefixes     = ["10.0.2.0/24"]
}
