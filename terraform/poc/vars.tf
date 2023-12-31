variable "location" {
  type        = string
  default     = "Australia East"
  description = "Resoucre Location"
}

variable "application_insights_type" {
  type        = string
  default     = "web"
  description = "Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created. "
}

variable "retention_in_days" {
  type        = string
  default     = "90"
  description = "Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90"
}

variable "SQL_ADMIN_PASS" {
  description = "The SQL managed instance admin password"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Common tags applied to all the resources created in this module"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Type of environment"
  type        = string
  default     = "poc"
}

variable "solution_name" {
  description = "Name of the solution"
  type        = string
  default     = "centric"
}

variable "location_short_name" {
  description = "Shot name of location, approved locations short names ae and ase"
  type        = string
  default     = "ae"
}

variable "location_short_name_ase" {
  description = "Shot name of location, approved locations short names ae and ase"
  type        = string
  default     = "ase"
}