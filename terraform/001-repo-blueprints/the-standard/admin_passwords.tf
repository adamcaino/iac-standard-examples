resource "azurerm_key_vault_secret" "windows_password_1" {
  name         = "vm-win-admin-pass"
  value        = var.admin_password_windows
  key_vault_id = azurerm_key_vault.shared_vault_for_everything.id
}

resource "azurerm_key_vault_secret" "linux_password_2" {
  name         = "vm-lin-admin-pass"
  value        = var.admin_password_linux
  key_vault_id = azurerm_key_vault.shared_vault_for_everything.id
}
