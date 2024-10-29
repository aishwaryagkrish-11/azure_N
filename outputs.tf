output "vm1_public_ip" {
  value = azurerm_public_ip.pip1.ip_address
}

output "vm2_public_ip" {
  value = azurerm_public_ip.pip2.ip_address
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "key_vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}