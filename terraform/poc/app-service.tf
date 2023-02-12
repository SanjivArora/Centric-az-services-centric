## Pasview backend service
module "app-sevrice" {
  source = "../../modules/azure-app-service"

  create_resource_group          = false
  resource_group_name            = azurerm_resource_group.this_rg.name
  location                       = var.location
  create_log_analytics_workspace = true
  log_analytics_workspace_name   = "poc-centric-ae-log-workspace"
  log_analytics_workspace_sku    = "PerGB2018"
  log_analytics_data_retention   = 30
  create_service_plan            = true
  service_plan_name              = "poc-centric-ae-service-plan"
  os_type                        = "Windows"
  service_plan_sku_name          = "B1"
  create_application_insights    = true
  application_insights_name      = "poc-centric-ae-app-insights"
  application_insights_type      = "web"
  application_insights_enabled   = true
  service_name                   = "poc-centric-pasview-ae-service"
  site_config = {
    minimum_tls_version = "1.2"
    always_on           = "true"
    application_stack = {
      current_stack  = "dotnet"
      dotnet_version = "v6.0"
    }
  }
  app_settings = {
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES     = "10"
    InstrumentationEngine_EXTENSION_VERSION = "disabled"
    WEBSITE_DNS_SERVER = "10.166.12.4"
    WEBSITE_RUN_FROM_PACKAGE = "1"
    minTlsVersion = "1.2"
  }
  app_service_vnet_integration_subnet_id = data.azurerm_subnet.webapp.id
  depends_on = [
    azurerm_resource_group.this_rg
  ]
}

### Pasview frontend webapp
module "app-sevrice-pasview-frontend" {
  source = "../../modules/azure-app-service"

  create_resource_group          = false
  resource_group_name            = azurerm_resource_group.this_rg.name
  location                       = var.location
  create_log_analytics_workspace = false
  log_analytics_workspace_name   = "poc-centric-ae-log-workspace"
  log_analytics_workspace_sku    = "PerGB2018"
  log_analytics_data_retention   = 30
  create_service_plan            = false
  service_plan_name              = "poc-centric-ae-service-plan"
  os_type                        = "Windows"
  service_plan_sku_name          = "B1"
  create_application_insights    = false
  application_insights_name      = "poc-centric-ae-app-insights"
  application_insights_type      = "web"
  application_insights_enabled   = true
  service_name                   = "poc-centric-pasview-ae-front-end-service"
  site_config = {
    minimum_tls_version = "1.2"
    always_on           = "true"
    application_stack = {
      current_stack  = "node"
      node_version = "14-LTS"
    }
  }
  app_settings = {
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES     = "10"
    InstrumentationEngine_EXTENSION_VERSION = "disabled"
    WEBSITE_DNS_SERVER = "10.166.12.4"
    WEBSITE_RUN_FROM_PACKAGE = "1"
    minTlsVersion = "1.2"
  }
  app_service_vnet_integration_subnet_id = data.azurerm_subnet.webapp.id
  depends_on = [
    azurerm_resource_group.this_rg
  ]
}

## Mailer frontend
module "app-sevrice-mailer-frontend" {
  source = "../../modules/azure-app-service"

  create_resource_group          = false
  resource_group_name            = azurerm_resource_group.this_rg.name
  location                       = var.location
  create_log_analytics_workspace = false
  log_analytics_workspace_name   = "poc-centric-ae-log-workspace"
  log_analytics_workspace_sku    = "PerGB2018"
  log_analytics_data_retention   = 30
  create_service_plan            = false
  service_plan_name              = "poc-centric-ae-service-plan"
  os_type                        = "Windows"
  service_plan_sku_name          = "B1"
  create_application_insights    = false
  application_insights_name      = "poc-centric-ae-app-insights"
  application_insights_type      = "web"
  application_insights_enabled   = true
  service_name                   = "poc-centric-mailer-ae-front-end-service"
  site_config = {
    minimum_tls_version = "1.2"
    always_on           = "true"
    application_stack = {
      current_stack  = "node"
      node_version = "14-LTS"
    }
  }
  app_settings = {
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES     = "10"
    InstrumentationEngine_EXTENSION_VERSION = "disabled"
    WEBSITE_DNS_SERVER = "10.166.12.4"
    WEBSITE_RUN_FROM_PACKAGE = "1"
    minTlsVersion = "1.2"
  }
  app_service_vnet_integration_subnet_id = data.azurerm_subnet.webapp.id
  depends_on = [
    azurerm_resource_group.this_rg
  ]
}

## Mailer backend
module "app-sevrice-mailer-backend" {
  source = "../../modules/azure-app-service"

  create_resource_group          = false
  resource_group_name            = azurerm_resource_group.this_rg.name
  location                       = var.location
  create_log_analytics_workspace = false
  log_analytics_workspace_name   = "poc-centric-ae-log-workspace"
  log_analytics_workspace_sku    = "PerGB2018"
  log_analytics_data_retention   = 30
  create_service_plan            = false
  service_plan_name              = "poc-centric-ae-service-plan"
  os_type                        = "Windows"
  service_plan_sku_name          = "B1"
  create_application_insights    = false
  application_insights_name      = "poc-centric-ae-app-insights"
  application_insights_type      = "web"
  application_insights_enabled   = true
  service_name                   = "poc-centric-mailer-ae-backend-service"
  site_config = {
    minimum_tls_version = "1.2"
    always_on           = "true"
    application_stack = {
      current_stack  = "dotnet"
      dotnet_version = "v6.0"
    }
  }
  app_settings = {
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES     = "10"
    InstrumentationEngine_EXTENSION_VERSION = "disabled"
    WEBSITE_DNS_SERVER = "10.166.12.4"
    WEBSITE_RUN_FROM_PACKAGE = "1"
    minTlsVersion = "1.2"
  }
  app_service_vnet_integration_subnet_id = data.azurerm_subnet.webapp.id
  depends_on = [
    azurerm_resource_group.this_rg
  ]
}

## Mailer backend
module "app-sevrice-iam" {
  source = "../../modules/azure-app-service"

  create_resource_group          = false
  resource_group_name            = azurerm_resource_group.this_rg.name
  location                       = var.location
  create_log_analytics_workspace = false
  log_analytics_workspace_name   = "poc-centric-ae-log-workspace"
  log_analytics_workspace_sku    = "PerGB2018"
  log_analytics_data_retention   = 30
  create_service_plan            = false
  service_plan_name              = "poc-centric-ae-service-plan"
  os_type                        = "Windows"
  service_plan_sku_name          = "B1"
  create_application_insights    = false
  application_insights_name      = "poc-centric-ae-app-insights"
  application_insights_type      = "web"
  application_insights_enabled   = true
  service_name                   = "poc-centric-ae-iam-service"
  site_config = {
    minimum_tls_version = "1.2"
    always_on           = "true"
    application_stack = {
      current_stack  = "dotnet"
      dotnet_version = "v6.0"
    }
  }
  app_settings = {
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES     = "10"
    InstrumentationEngine_EXTENSION_VERSION = "disabled"
    WEBSITE_DNS_SERVER = "10.166.12.4"
    WEBSITE_RUN_FROM_PACKAGE = "1"
    minTlsVersion = "1.2"
  }
  app_service_vnet_integration_subnet_id = data.azurerm_subnet.webapp.id
  depends_on = [
    azurerm_resource_group.this_rg
  ]
}