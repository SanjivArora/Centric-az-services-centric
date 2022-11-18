resource "azurerm_network_security_group" "sql_nsg" {
  name                = "poc-centric-sqlmi-nsg-ae-1"
  location            = azurerm_resource_group.sqlmi_rg.location
  resource_group_name = azurerm_resource_group.sqlmi_rg.name
}

resource "azurerm_network_security_rule" "allow_management_inbound" {
  name                        = "allow_management_inbound"
  priority                    = 106
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["9000", "9003", "1438", "1440", "1452"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sqlmi_rg.name
  network_security_group_name = azurerm_network_security_group.sql_nsg.name
}

resource "azurerm_network_security_rule" "allow_misubnet_inbound" {
  name                        = "allow_misubnet_inbound"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.0.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sqlmi_rg.name
  network_security_group_name = azurerm_network_security_group.sql_nsg.name
}

resource "azurerm_network_security_rule" "allow_health_probe_inbound" {
  name                        = "allow_health_probe_inbound"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sqlmi_rg.name
  network_security_group_name = azurerm_network_security_group.sql_nsg.name
}

resource "azurerm_network_security_rule" "allow_tds_inbound" {
  name                        = "allow_tds_inbound"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "1433"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sqlmi_rg.name
  network_security_group_name = azurerm_network_security_group.sql_nsg.name
}

resource "azurerm_network_security_rule" "deny_all_inbound" {
  name                        = "deny_all_inbound"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sqlmi_rg.name
  network_security_group_name = azurerm_network_security_group.sql_nsg.name
}

resource "azurerm_network_security_rule" "allow_management_outbound" {
  name                        = "allow_management_outbound"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443", "12000"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sqlmi_rg.name
  network_security_group_name = azurerm_network_security_group.sql_nsg.name
}

resource "azurerm_network_security_rule" "allow_misubnet_outbound" {
  name                        = "allow_misubnet_outbound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.0.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sqlmi_rg.name
  network_security_group_name = azurerm_network_security_group.sql_nsg.name
}

resource "azurerm_network_security_rule" "deny_all_outbound" {
  name                        = "deny_all_outbound"
  priority                    = 4096
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sqlmi_rg.name
  network_security_group_name = azurerm_network_security_group.sql_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "sqlmi_association" {
  subnet_id                 = data.azurerm_subnet.sqlmi.id
  network_security_group_id = azurerm_network_security_group.sql_nsg.id
}

resource "azurerm_route_table" "sqlmi_rt" {
  name                          = "poc-centric-sqlmi-rt-ae-1"
  location                      = azurerm_resource_group.sqlmi_rg.location
  resource_group_name           = azurerm_resource_group.sqlmi_rg.name
  disable_bgp_route_propagation = false
}

resource "azurerm_mssql_managed_instance" "this_sqlmi" {
  name                = "poc-centric-sqlmi-ae-1"
  resource_group_name = azurerm_resource_group.sqlmi_rg.name
  location            = azurerm_resource_group.sqlmi_rg.location

  license_type       = "BasePrice"
  sku_name           = "GP_Gen5"
  storage_size_in_gb = 32
  subnet_id          = data.azurerm_subnet.sqlmi.id
  vcores             = 4

  administrator_login          = "sqladministrator"
  administrator_login_password = var.SQL_ADMIN_PASS
  timezone_id                  = "New Zealand Standard Time"

  timeouts {
    create = "300m"
    update = "90m"
    read   = "5m"
    delete = "300m"
  }
  depends_on = [
    azurerm_route_table.sqlmi_rt,
    azurerm_subnet_network_security_group_association.sqlmi_association
  ]
}