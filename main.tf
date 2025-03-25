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

}

# récupère dynamiquement les zones de disponibilité en s'assurant que az soit dans le fichier main
data "aws_availability_zones" "available" {}


#AWS S3 backend to store tf.state file
#first create bucket on aws user interface or aws cli

terraform {
  backend "s3" {
    bucket  = "wordpress-bucket-astride-dst"
    key     = "terraform.tfstate"
    region  = "eu-west-3"
    encrypt = true #active le chiffrement par défaut (AES-256)
  }
}

#Appel des modules
# Module Réseau
module "networking" {
  source         = "./modules/networking"
  vpc_cidr       = var.vpc_cidr
  pubsn_cidr     = var.pubsn_cidr
  privat_sn_cidr = var.privat_sn_cidr
  azs            = data.aws_availability_zones.available.names
}

# Module Base de données RDS
module "rds" {
  source             = "./modules/rds"
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
  availability_zones = data.aws_availability_zones.available.names
  db_instance_type   = var.db_instance_type
  ec2_sg_id          = module.ec2.ec2_sg_id #groupe de sécurité de notre rds

  # Récupération des valeurs de la base de données RDS depuis `module.rds`
  database_name     = var.database_name
  database_user     = var.database_user
  database_password = var.database_password

}


#Appel du  Module EC2 WordPress
module "ec2" {
  source            = "./modules/ec2"
  vpc_id            = module.networking.vpc_id
  public_subnet_id  = module.networking.public_subnet_ids[0]  # Premier subnet public
  private_subnet_id = module.networking.private_subnet_ids[0] # premier subnet privé
  availability_zone = data.aws_availability_zones.available.names[0]
  database_password = module.rds.rds_password
  #les valeurs de notre rds
  database_name = module.rds.rds_db_name
  database_user = module.rds.rds_username
  database_host = module.rds.rds_endpoint #  Récupéré depuis le module RDS
  # key_name      = var.key_name
}


# Module EBS
module "ebs" {
  source            = "./modules/ebs"
  vpc_id            = module.networking.vpc_id
  ec2_id            = module.ec2.ec2_id
  availability_zone = data.aws_availability_zones.available.names[0] # module.networking.azs[0]
}
