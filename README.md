# terraform-cloufoundry-matomo

Terraform module for deploying matomo to cloudfoundry

## Requirements

| Name         | Version     |
| ------------ | ----------- |
| terraform    | >= 0.13.0   |
| cloudfoundry | >= 0.1206.0 |

## Providers

| Name         | Version     |
| ------------ | ----------- |
| cloudfoundry | >= 0.1206.0 |
| random       | n/a         |

## Inputs

| Name            | Description                                                                          | Type       | Default             | Required |
| --------------- | ------------------------------------------------------------------------------------ | ---------- | ------------------- | :------: |
| cf_app_domain   | The Cloudfoundry regular app domain to use                                           | `string`   | `""`                |    no    |
| cf_org_name     | Cloudfoundry ORG name to use for reverse proxy                                       | `string`   | n/a                 |   yes    |
| cf_user         | The Cloudfoundry user to assign rights to the app to                                 | `string`   | n/a                 |   yes    |
| db_broker       | The Database broker to use for requesting a mysql database                           | `string`   | `"hsdp-rds"`        |    no    |
| db_json_params  | Optional DB JSON params                                                              | `string`   | `"{}"`              |    no    |
| db_plan         | The Database plan to use                                                             | `string`   | `"mysql-micro-dev"` |    no    |
| docker_password | Docker registry password                                                             | `string`   | `""`                |    no    |
| docker_username | Docker registry username                                                             | `string`   | `""`                |    no    |
| environment     | Pass environment variable to the app                                                 | `map(any)` | `{}`                |    no    |
| matomo_image    | Image to use for matomo app                                                          | `string`   | `"matomo:latest"`   |    no    |
| name_postfix    | The postfix string to append to the space, hostname, etc. Prevents namespace clashes | `string`   | `""`                |    no    |

## Outputs

No output.
