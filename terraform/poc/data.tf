data "azurerm_subnet" "appservice" {
  name                 = "poc-centric-appservice-sn-ae-1"
  virtual_network_name = "poc-centric-vnet-ae-1"
  resource_group_name  = "poc-centric-networking-rg-ae-1"
}

data "azurerm_subnet" "webapp" {
  name                 = "poc-centric-webapp-sn-ae-1"
  virtual_network_name = "poc-centric-vnet-ae-1"
  resource_group_name  = "poc-centric-networking-rg-ae-1"
}

data "azurerm_subnet" "sqlmi" {
  name                 = "poc-centric-sqlmi-sn-ae-1"
  virtual_network_name = "poc-centric-vnet-ae-1"
  resource_group_name  = "poc-centric-networking-rg-ae-1"
}

data "azurerm_subnet" "appgw" {
  name                 = "poc-centric-appgw-sn-ae-1"
  virtual_network_name = "poc-centric-vnet-ae-1"
  resource_group_name  = "poc-centric-networking-rg-ae-1"
}
