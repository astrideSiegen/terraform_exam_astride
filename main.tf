terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# la région aws ou nous voulons déployer nos différentes ressources
provider "aws" {
  region     = var.region
  access_key = "********************************"         # la clé d'acces crée pour l'utilisateur qui sera utilisé par terraform
  secret_key = "****************************************" # la clé sécrète crée pour l'utilisateur qui sera utilisé par terraform
}

# AWS S3 backend to store tf.state file
#first create bucket on aws user interface or aws cli
# terraform {
#   backend "s3" {
#     bucket = "wordpress-bucket_astride_dst"
#     key    = "terraform.tfstate"
#     region = "eu-west-3"

#   }
# }

#Appel des modules
module "networking" {
  source    = "./networking"
  namespace = var.namespace
}
# Module Réseau
module "networking" {
  source               = "./networking"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = data.aws_availability_zones.available.names
}

# Module EC2 WordPress
module "ec2" {
  source        = "./ec2"
  vpc_id        = module.networking.vpc_id
  public_subnet = module.networking.public_subnet_ids[0]
  instance_type = var.instance_type
  key_name      = var.key_name
}

# Module Base de données RDS
module "rds" {
  source             = "./rds"
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  db_instance_type   = var.db_instance_type
}

# Module EBS
module "ebs" {
  source            = "./ebs"
  ec2_id            = module.ec2.instance_id
  availability_zone = module.ec2.availability_zone
}
