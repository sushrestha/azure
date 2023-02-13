// Azure Cloud
provider "azurerm" {
    skip_provider_registration = true
    features {

    }
}

// creating resource group
resource "azurerm_resource_group" "rg-labs" {
    name = "rg-terraformlabs"
    location = var.resourceLocation //"East US"
}

//Add storage account
resource "azurerm_storage_account" "str_StateStore" {
    name = "terrformlabs${lower(random_string.random.result)}" //"terraformlabs"
    location = azurerm_resource_group.rg-labs.location
    resource_group_name = azurerm_resource_group.rg-labs.name //azurerm_resourceType.NAME.Property
    account_tier = "Standard"
    allow_nested_items_to_be_public = false // to disable blob public access - anonymous
    account_replication_type = "LRS"
tags = {
  "iac" = "terraform"
}
// first dependent resources provisioned
depends_on = [
  azurerm_resource_group.rg-labs,
  random_string.random
]
}

// For storage container
resource "azurerm_storage_container" "str_statecontainer" {
  name = "terraformstate"
  storage_account_name = azurerm_storage_account.str_StateStore.name
  //container_access_type = "private"
}

// random string for storage account name to make it unique
resource "random_string" "random" {
  length = 8
  special = false
}