locals {
  env         = var.environment
  name_prefix = "${var.vpcname}-${var.environment}-${var.region}"

  tags = {
    env        = local.env
    region     = var.region
    created_by = "Ilyas"
    Project    = var.vpcname
  }
}
