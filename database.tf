data "cloudfoundry_service" "rds" {
  name = var.db_broker
}

resource "cloudfoundry_service_instance" "database" {
  name         = "matomo-rds"
  space        = var.space_id
  service_plan = data.cloudfoundry_service.rds.service_plans[var.db_plan]
  json_params  = var.db_json_params
}

resource "cloudfoundry_service_key" "database_key" {
  name             = "key"
  service_instance = cloudfoundry_service_instance.database.id
}