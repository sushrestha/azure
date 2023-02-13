// displaying whole resource group object
output "rg_main_output" {
  value = azurerm_resource_group.rg-labs
}

# // get a single value
output "storage_account_name" {
  value = azurerm_storage_account.str_StateStore.name
}