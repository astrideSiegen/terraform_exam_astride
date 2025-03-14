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
  region  = 
  access_key = "********************************"         # la clé d'acces crée pour l'utilisateur qui sera utilisé par terraform
  secret_key = "****************************************" # la clé sécrète crée pour l'utilisateur qui sera utilisé par terraform
}

# AWS S3 backend to store tf.state file
#first create bucket on aws user interface or aws cli
# terraform {
#   backend "s3" {
#     bucket = "eshop-tf-backend-bucket"
#     key    = "terraform.tfstate"
#     region = "eu-west-3"

#   }
# }

