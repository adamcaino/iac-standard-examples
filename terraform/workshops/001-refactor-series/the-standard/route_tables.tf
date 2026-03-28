# Messy NSG Naming
resource "azurerm_route_table" "windows" {
  name                = "rt-${var.workload_name}-windows"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_route_table_association" "windows" {
  subnet_id      = azurerm_subnet.windows.id
  route_table_id = azurerm_route_table.windows.id
}

# The IaC Standard Naming Convention
resource "azurerm_route_table" "linux" {
  name                = "rt-${var.workload_name}-linux"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_route_table_association" "linux" {
  subnet_id      = azurerm_subnet.linux.id
  route_table_id = azurerm_route_table.linux.id
}
