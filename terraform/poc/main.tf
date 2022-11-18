resource "azurerm_resource_group" "this_rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_resource_group" "sqlmi_rg" {
  name     = "poc-centirc-sqlmi-ae-rg"
  location = var.location
}


