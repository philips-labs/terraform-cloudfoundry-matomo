
resource "random_password" "admin_password" {
  length = 16
}

resource "random_string" "matomo_salt" {
  length  = 32
  special = false
  upper   = false
}

resource "cloudfoundry_app" "matomo" {
  name         = "matomo"
  space        = var.space_id
  memory       = 512
  disk_quota   = 2048
  docker_image = var.matomo_image
  docker_credentials = {
    username = var.docker_username
    password = var.docker_password
  }
  environment = merge({
    MATOMO_DATABASE_HOST          = cloudfoundry_service_key.database_key.credentials.hostname
    MATOMO_DATABASE_TABLES_PREFIX = "matomo_"
    MATOMO_DATABASE_USERNAME      = cloudfoundry_service_key.database_key.credentials.username
    MATOMO_DATABASE_PASSWORD      = cloudfoundry_service_key.database_key.credentials.password
    MATOMO_DATABASE_DBNAME        = cloudfoundry_service_key.database_key.credentials.db_name
    MATOMO_DOMAINS                = cloudfoundry_route.matomo.endpoint
    MATOMO_ADMIN_PASSWORD         = random_password.admin_password.result
    MATOMO_GENERAL_SALT           = random_string.matomo_salt.result
    MATOMO_TRUSTED_HOST           = cloudfoundry_route.matomo.endpoint
    MATOMO_FORCE_SSL              = "1"
    MATOMO_ASSUME_SSL             = "1"
    MATOMO_TRUSTED_HOST           = "https://${cloudfoundry_route.matomo.endpoint}"
  }, var.environment)

  routes {
    route = cloudfoundry_route.matomo.id
  }
}

resource "cloudfoundry_route" "matomo" {
  domain   = data.cloudfoundry_domain.app_domain.id
  space    = var.space_id
  hostname = var.hostname
}
