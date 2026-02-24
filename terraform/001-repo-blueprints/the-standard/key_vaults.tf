data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "shared_vault_for_everything" {
  name                        = "kv${var.name}${var.env}"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Delete",
      "Update"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete"
    ]
  }
}
