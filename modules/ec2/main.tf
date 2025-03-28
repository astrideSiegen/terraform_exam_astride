# récupère dynamiquement les zones de disponibilité en s'assurant que az soit dans le fichier main
data "aws_availability_zones" "available" {}

#Créer une Data Source aws_ami pour sélectionner l'ami disponible dans la région eu-west-3
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  #Récupère uniquement les AMI avec stockage GP2 (général-purpose SSD)
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Configurer l'instance EC2 dans un sous-réseau public
resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  # key_name                    = var.key_name
  subnet_id              = var.public_subnet_id
  availability_zone      = data.aws_availability_zones.available.names[0] # Définit l'AZ de l'ec2 qui doit etre la mm que celle de ebs
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = var.key_name

  #besoin de monitoring et Network interface?

  # user_data              = file("install_wordpress.sh")

  # Ajouter les valeurs de la base de données lors de l'installation de wordpress sur notre ec2 de facon dynamique
  user_data = templatefile("${path.module}/../../install_wordpress.sh", {
    database_name     = var.database_name
    database_user     = var.database_user
    database_password = var.database_password
    database_host     = var.database_host # Récupéré depuis le module RDS
  })

  tags = {
    "Name" = "${var.namespace}-EC2"
  }

  depends_on = [aws_security_group.ec2_sg] # Assure la création du SG avant EC2
}

resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id

  # Autoriser le trafic HTTP (WordPress)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #cidr_blocs autorisés à accéder à la machine à travers ce bloc, tout comme c'est sur le web
  }

  # Autoriser le trafic HTTPS (Sécurisé)
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] #cidr_blocs autorisés à accéder à la machine à travers ce bloc
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "EC2-SG"
  }
}


