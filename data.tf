data "cloudfoundry_domain" "app_domain" {
  name = var.cf_app_domain
}

data "cloudfoundry_domain" "apps_internal_domain" {
  name = "apps.internal"
}
