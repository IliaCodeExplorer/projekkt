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
  key_name          = module.bastion.key_name
}

module "rds" {
  source      = "./rds"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.subnet_ids
  db_name     = "mydatabase"
  db_username = "admin"
  db_password = "password1"
}
module "elb" {
  source             = "./elb"
  environment        = "prod"
  vpc_id             = module.vpc.vpc_id
public_subnet =  module.vpc.public_subnet_id
public_subnet2 = module.vpc.public_subnet2

  security_groups = module.security.web_sg_id

  common_tags        = { "Project" = "MyProject", "Environment" = "prod" }
}

module "autoscaling" {
  source = "./autoscaling"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 2
  key_name = module.bastion.key_name
  # vpc_zone_identifier  = module.vpc.private_subnets_ids
  private_subnet = module.vpc.private_subnet_id
  security_groups      = [module.security.web_sg_id]
  target_group_arn     = module.elb.target_group_arn
  common_tags          = {
    Project     = "MyProject"
    Environment = "prod"
  }
  environment = "prod"
}
