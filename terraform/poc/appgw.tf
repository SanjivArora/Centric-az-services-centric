# resource "azurerm_public_ip" "appgw-pip" {
#   name                = "poc-centric-pip-1"
#   resource_group_name = azurerm_resource_group.this_rg.name
#   location            = azurerm_resource_group.this_rg.location
#   allocation_method   = "Static"
#   sku = "Standard"
#   zones = [1, 2, 3]
# }

# locals {
#   base_name = "${var.environment}-centric-appgw-ae"
#   pasview_frontend = "poc-centric-pasview-ae-service.azurewebsites.net"
#   pasview_backend = "poc-centric-pasview-ae-front-end-service.azurewebsites.net"
# }

# module "appgw_v2" {
#   source  = "../../modules/app-gw"

#   appgw_name          = local.base_name
#   location            = "AustraliaEast"
#   location_short      = "ae"
#   resource_group_name = "poc-centirc-appservice-rg-ae-1"
#   appgw_pip_id = azurerm_public_ip.appgw-pip.id
#   subnet_id = data.azurerm_subnet.appgw.id
#   appgw_private_ip = "10.166.138.41"

#   appgw_backend_http_settings = [{
#     name                  = "${local.base_name}-backhttpsettings"
#     cookie_based_affinity = "Disabled"
#     path                  = "/"
#     port                  = 443
#     protocol              = "Https"
#     request_timeout       = 300
#     probe_name            = "${local.base_name}-health-probe"
#   }]

#   appgw_backend_pools = [{
#     name  = "${local.base_name}-backendpool-01"
#     fqdns = [local.pasview_frontend]
#   },
#   {
#     name = "${local.base_name}-backendpool-02"
#     fqdns = [local.pasview_backend]
#   }
  
#   ]

#   appgw_routings = [{
#     name                       = "${local.base_name}-routing-https"
#     rule_type                  = "PathBasedRouting"
#     http_listener_name         = "${local.base_name}-listener-https"
#     backend_address_pool_name  = "${local.base_name}-backendpool"
#     backend_http_settings_name = "${local.base_name}-backhttpsettings"
#     url_path_map_name = "${local.base_name}-pasview-url-path-map"
#   }]


#   appgw_http_listeners = [{
#     name                           = "${local.base_name}-listener-https"
#     frontend_port_name             = "frontend-https-port"
#     protocol                       = "Http" #tofix
#     # ssl_certificate_name           = "${local.base_name}-example-com-sslcert"
#     require_sni                    = false #tofix
#   }]

#   frontend_port_settings = [{
#     name = "frontend-https-port"
#     port = 80
#   }]

#   appgw_url_path_map = [{
#     name                               = "${local.base_name}-pasview-url-path-map"
#     default_backend_http_settings_name = "${local.base_name}-backhttpsettings"
#     default_backend_address_pool_name  = "${local.base_name}-backendpool-01"

#     path_rules = [
#       {
#         name                       = "${local.base_name}-frontend-url-path-rule"
#         backend_address_pool_name  = "${local.base_name}-backendpool-01"
#         backend_http_settings_name = "${local.base_name}-backhttpsettings"
#         paths                      = ["/PASView_WDHB/*"]
#       },
#       {
#         name                       = "${local.base_name}-backend-url-path-rule"
#         backend_address_pool_name  = "${local.base_name}-backendpool-02"
#         backend_http_settings_name = "${local.base_name}-backhttpsettings"
#         paths                      = ["/PASView_WDHB_API/*"]
#       }
#     ]
#   }]

#   appgw_probes = [{
#     name = "${local.base_name}-health-probe"
#     port = 443
#     interval = 30
#     path = "/swagger/"
#     protocol = "Https"
#     timeout = 30
#     pick_host_name_from_backend_http_settings = true

#   }
#   ]

#   autoscaling_parameters = {
#     min_capacity = 1
#     max_capacity = 2
#   }

# }

