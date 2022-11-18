module "app-sevrice" {
  source = "../../modules/azure-app-service" 

  create_resource_group          = true
  resource_group_name            = var.rg_name
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
  service_name                   = "poc-centric-ae-service"
  site_config = {
    minimum_tls_version = "1.2"
    always_on           = "false"
    application_stack = {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }
  }
  app_settings = {
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES     = "10"
    InstrumentationEngine_EXTENSION_VERSION = "disabled"
  }
  app_service_vnet_integration_subnet_id = data.azurerm_subnet.webapp.id
}

