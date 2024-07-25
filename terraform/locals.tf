# locals.tf contains local values, expressions that could be used in the main.tf

locals {
  resource_env_suffix = "${var.location}-${var.environment}"

}