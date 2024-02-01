module "vpc" {
  source = "./vpc"

  cidr_block         = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  common_tags = {
    Project     = "MyProject"
    environment = "prod"
  }
}
module "security" {
  source = "./security"
  vpc_id = module.vpc.vpc_id
  common_tags = {
    Project     = "MyProject"
    Environment = "prod"
    CreatedBy   = "Ilyas"
  }
}

module "bastion" {
  source = "./ec2/bastion"

  key_name         = "my-key"
  public_subnet_id = module.vpc.public_subnet_id
  vpc_id           = module.vpc.vpc_id
  common_tags = {
    Project     = "MyProject"
    Environment = "prod"
  }
}
module "app_serv_ec2" {
  source            = "./ec2/app_server"
  private_subnet_id = module.vpc.private_subnet_id
  vpc_id            = module.vpc.vpc_id
  key_name          = "key-app"
}

module "rds" {
  source      = "./rds"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.subnet_ids
  db_name     = "mydatabase"
  db_username = "admin"
  db_password = "password1"
}
