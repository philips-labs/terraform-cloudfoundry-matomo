output "matomo_endpoint" {
  description = "The url for the matomo instance"
  value       = cloudfoundry_route.matomo.endpoint
}
