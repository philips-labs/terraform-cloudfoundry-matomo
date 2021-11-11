variable "space_id" {
  type        = string
  description = "The CloudFoundry space to deploy matomo to"
}

variable "cf_app_domain" {
  description = "The Cloudfoundry app domain to use for routes to matomo"
  type        = string
}


variable "name_postfix" {
  type        = string
  description = "The postfix string to append to the space name. Prevents namespace clashes"
  default     = ""
}

variable "hostname" {
  type        = string
  description = "The hostname to use on the cf_app_domain for public access"
}

variable "matomo_image" {
  description = "Image to use for matomo app"
  default     = "philipslabs/cf-matomo:latest"
  type        = string
}

variable "environment" {
  type        = map(any)
  description = "Pass extra environment variables to the app"
  default     = {}
}

variable "docker_username" {
  type        = string
  description = "Docker registry username"
  default     = ""
}

variable "docker_password" {
  type        = string
  description = "Docker registry password"
  default     = ""
}

variable "db_broker" {
  type        = string
  description = "The Database broker to use for requesting a mysql database"
  default     = "hsdp-rds"
}

variable "db_plan" {
  type        = string
  description = "The Database plan to use"
  default     = "mysql-micro-dev"
}

variable "db_json_params" {
  type        = string
  description = "Optional DB JSON params"
  default     = "{}"
}
