data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this_vault" {
  name                            = "poc-centric-ae-vault"
  location                        = azurerm_resource_group.this_rg.location
  resource_group_name             = azurerm_resource_group.this_rg.name
  enabled_for_disk_encryption     = true
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = true
  enabled_for_deployment          = true
  enabled_for_template_deployment = true


  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List",
    ]

    secret_permissions = [
      "Get", "List",
    ]

    storage_permissions = [
      "Get", "List",
    ]

    certificate_permissions = [
      "Get", "List",
    ]
  }
}