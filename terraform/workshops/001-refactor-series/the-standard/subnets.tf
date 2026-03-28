resource "azurerm_subnet" "windows" {
  name                 = "snet-win-${var.workload_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.workload.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "linux" {
  name                 = "snet-lin-${var.workload_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.workload.name
  address_prefixes     = ["10.0.2.0/24"]
}
