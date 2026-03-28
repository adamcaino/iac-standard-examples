resource "azurerm_key_vault_secret" "windows_admin" {
  name         = "vm-windows-admin-password"
  value        = var.admin_password_windows
  key_vault_id = azurerm_key_vault.windows.id

  depends_on = [azurerm_key_vault.windows]
}

resource "azurerm_key_vault_secret" "linux_admin" {
  name         = "vm-linux-admin-password"
  value        = var.admin_password_linux
  key_vault_id = azurerm_key_vault.linux.id

  depends_on = [azurerm_key_vault.linux]
}
