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


variable "matomo" {
  type = object({
    docker_image    = optional(string)
    docker_username = optional(string)
    docker_password = optional(string)
    environment     = optional(map(any))
  })
  default = {}
}

variable "oidc_proxy" {
  type = object({
    docker_image    = optional(string)
    docker_username = optional(string)
    docker_password = optional(string)
  })
  default = {}
}

locals {  
  matomo = defaults(var.matomo, {
    docker_image = "philipslabs/cf-matomo:latest"
    environment  = {}
  })

  oidc_proxy = defaults(var.oidc_proxy, {
    docker_image = "philipslabs/cf-matomo-oidcproxy:latest"
  })
}
