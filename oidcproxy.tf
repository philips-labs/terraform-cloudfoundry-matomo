resource "cloudfoundry_app" "oidcproxy" {
  name         = "oidcproxy"
  space        = var.space_id
  memory       = 128
  disk_quota   = 100
  docker_image = local.oidc_proxy.docker_image
  docker_credentials = {
    username = local.oidc_proxy.docker_username
    password = local.oidc_proxy.docker_password
  }
  environment = {
    MATOMO_ENDPOINT = cloudfoundry_route.matomo.endpoint
  }

  routes {
    route = cloudfoundry_route.oidc_proxy.id
  }
}

resource "cloudfoundry_route" "oidc_proxy" {
  domain   = data.cloudfoundry_domain.app_domain.id
  space    = var.space_id
  hostname = var.hostname
  path     = "/_oauth/callback"
}
