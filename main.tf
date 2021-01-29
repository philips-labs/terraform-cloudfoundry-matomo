resource "random_id" "id" {
  byte_length = 8
}

resource "random_password" "password" {
  length = 16
}

locals {
  postfix_name  = var.name_postfix != "" ? var.name_postfix : random_id.id.hex
  matomo_routes = [cloudfoundry_route.matomo.id, cloudfoundry_route.matomo_internal.id]
}

resource "random_string" "random" {
  length = 32
  special = false  
  upper = false
}


resource "cloudfoundry_app" "matomo" {
  name         = "matomo"
  space        = cloudfoundry_space.space.id
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
    MATOMO_ADMIN_PASSWORD         = random_password.password.result   
    MATOMO_GENERAL_SALT           = random_string.random.result 
  }, var.environment)

  dynamic "routes" {
    for_each = local.matomo_routes
    content {
      route = routes.value
    }
  }
}

resource "cloudfoundry_route" "matomo" {
  domain   = data.cloudfoundry_domain.app_domain.id
  space    = cloudfoundry_space.space.id
  hostname = "matomo-${local.postfix_name}"

  depends_on = [cloudfoundry_space_users.users]
}

resource "cloudfoundry_route" "matomo_internal" {
  domain   = data.cloudfoundry_domain.apps_internal_domain.id
  space    = cloudfoundry_space.space.id
  hostname = "matomo-${local.postfix_name}"

  depends_on = [cloudfoundry_space_users.users]
}