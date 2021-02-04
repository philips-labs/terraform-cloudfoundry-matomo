# terraform-cloudfoundry-Matomo

Terraform module for deploying Matomo to cloudfoundry.

You can create an instance of Matomo by using the module similar to the below.

```terraform
module "Matomo" {
  source = "github.com/philips-labs/terraform-cloudfoundry-Matomo"

  cf_org_name     = "my-org"
  cf_app_domain   = "my.cloudfoundry.com"
  cf_user         = "my-user"
  docker_password = "my-docker-pass"
  docker_username = "my-docker-user"
  hostname        = "my-analytics"
  matomo_image    = "philipslabs/cf-matomo:4.1-apache"
}
```

## Matomo Config

To enable us to sustain restarts of the cf app we automate the creation of the Matomo config file. We do this via the use of a custom dockerfile that add an entrypoint that merges environment variables with a templated config file. This happens at startup of the docker container.

Without this config you would need to go through the getting started wizard after each restart.

This only allows a minimum amount of config to be set, if additional config is required the config file template will need to be adapted. Alternatively some method or parsing environment variables into an ini file could be created.

## First Run

When Matomo first runs it needs to populate the schema of the database and configure some values there. This is a manual step you need to take care of when the database is first provisioned.

You will need to ssh into the running app and remove the generated config file

```bash
cf ssh <matomo-app>
$ rm /var/www/html/config/config.ini.php
```

This then triggers Matomo into "Getting Started" mode. You will then need to visit th public URL of your deployment in your browser and follow the onscreen wizard to connect to the database, deploy the schema and create a super users. Once you have done this you can then restart the app to revert to the generated config file.

```bash
cf restart Matomo
```

You should then have a configured Matomo instance that you can use, subsequent restarts or deployments should not need this step.

You should ensure that you select specific tag from https://hub.docker.com/r/philipslabs/cf-matomo for your docker container and note that the default is just to use `philipslabs/cf-matomo:latest`

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

| Name            | Description                                                                | Type       | Default                          | Required |
| --------------- | -------------------------------------------------------------------------- | ---------- | -------------------------------- | :------: |
| cf_app_domain   | The Cloudfoundry app domain to use for routes to Matomo                    | `string`   | n/a                              |   yes    |
| cf_org_name     | Cloudfoundry ORG name to deploy to.                                        | `string`   | n/a                              |   yes    |
| cf_user         | The Cloudfoundry user to assign rights to the app/space to                 | `string`   | n/a                              |   yes    |
| db_broker       | The Database broker to use for requesting a mysql database                 | `string`   | `"hsdp-rds"`                     |    no    |
| db_json_params  | Optional DB JSON params                                                    | `string`   | `"{}"`                           |    no    |
| db_plan         | The Database plan to use                                                   | `string`   | `"mysql-micro-dev"`              |    no    |
| docker_password | Docker registry password                                                   | `string`   | `""`                             |    no    |
| docker_username | Docker registry username                                                   | `string`   | `""`                             |    no    |
| environment     | Pass extra environment variables to the app                                | `map(any)` | `{}`                             |    no    |
| hostname        | The hostname to use on the cf_app_domain for public access                 | `string`   | n/a                              |   yes    |
| Matomo_image    | Image to use for Matomo app                                                | `string`   | `"philipslabs/cf-Matomo:latest"` |    no    |
| name_postfix    | The postfix string to append to the space name. Prevents namespace clashes | `string`   | `""`                             |    no    |

## Outputs

No output.
