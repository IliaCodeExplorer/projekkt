module "vpc" {
  source = "./modules/vpc"

  cidr_block         = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  environment        = "prod"
  common_tags = {
    Project = "MyProject"
  }
}
module "security" {
  source = "./security"
  vpc_id = module.vpc.vpc_id
  common_tags = {
    Project     = "MyProject"
    Environment = "dev"
    CreatedBy   = "Ilyas"
  }
}

module "bastion" {
  source = "./modules/bastion"

  key_name         = "my-key"
  public_subnet_id = module.vpc.public_subnet_id
  common_tags = {
    Project     = "MyProject"
    Environment = "prod"
  }
}
# module "app_serv_ec2" {
#   source = "./ec2/app_server"

# }