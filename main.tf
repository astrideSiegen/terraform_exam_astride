terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# récupère dynamiquement les zones de disponibilité en s'assurant que az soit dans le fichier main
data "aws_availability_zones" "available" {}

# la région aws ou nous voulons déployer nos différentes ressources
provider "aws" {
  region     = var.region
  access_key = "********************************"         # la clé d'acces crée pour l'utilisateur qui sera utilisé par terraform
  secret_key = "****************************************" # la clé sécrète crée pour l'utilisateur qui sera utilisé par terraform
}

#AWS S3 backend to store tf.state file
#first create bucket on aws user interface or aws cli

terraform {
  backend "s3" {
    bucket = "wordpress-bucket-astride-dst"
    key    = "terraform.tfstate"
    region = var.region

  }
}

#Appel des modules
# Module Réseau
module "networking" {
  source         = "./modules/networking"
  vpc_cidr       = var.vpc_cidr
  pubsn_cidr     = var.public_subnet_cidrs
  privat_sn_cidr = var.private_subnet_cidrs
  azs            = data.aws_availability_zones.available.names
}

#Appel du  Module EC2 WordPress
module "ec2" {
  source            = "./modules/ec2"
  vpc_id            = var.vpc_id
  public_subnet_id  = element(module.networking.public_subnet_ids, 0)  # Premier subnet public
  private_subnet_id = element(module.networking.private_subnet_ids, 1) # Deuxième subnet privé
  availability_zone = data.aws_availability_zones.names[0]
  #les valeurs de notre rds
  database_name     = module.rds.rds_db_name
  database_user     = module.rds.rds_username
  database_password = var.database_password
  database_host     = module.rds.rds_endpoint #  Récupéré depuis le module RDS
  # key_name      = var.key_name
}

# Module Base de données RDS
module "rds" {
  source             = "./rds"
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  db_instance_type   = module.rds.db_instance_type
  database_name      = module.rds.rds_db_name
  database_user      = module.rds.rds_db_user
  database_password  = module.rds.database_password
  database_host      = module.rds.rds_endpoint

}

# Module EBS
module "ebs" {
  source            = "./ebs"
  ec2_id            = module.ec2.instance_id
  availability_zone = data.aws_availability_zones.names[0] # module.networking.azs[0]
}
