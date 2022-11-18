resource "azurerm_resource_group" "this_rg" {
  name     = "poc-centirc-appservice-rg-ae-1"
  location = var.location

  tags = merge(
    local.common_tags, {
      Name = "${var.environment}-${var.solution_name}-appservice-rg-${var.location_short_name}-1"
    }
  )
}

resource "azurerm_resource_group" "sqlmi_rg" {
  name     = "poc-centirc-sqlmi-ae-rg"
  location = var.location

  tags = merge(
    local.common_tags, {
      Name = "${var.environment}-${var.solution_name}-sqlmi-rg-${var.location_short_name}-1"
    }
  )
}


