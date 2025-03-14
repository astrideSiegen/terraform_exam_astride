#Créez une Data Source aws_ami pour sélectionner l'ami disponible dans votre région
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
# Configurer l'instance EC2 dans un sous-réseau public
resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  user_data                   = file("install_wordpress.sh")

  tags = {
    "Name" = "${var.namespace}-EC2"
  }
}

resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id

  # Autoriser le trafic HTTP (WordPress)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #cidr_blocs autorisés à accéder à la machine à travers ce bloc
  }

  # Autoriser le trafic HTTPS (Sécurisé)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #cidr_blocs autorisés à accéder à la machine à travers ce bloc
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2-SG"
  }
}

# Configurer l'instance EC2 dans un sous-réseau privé
# resource "aws_instance" "ec2_private" {
#   ami                         = data.aws_ami.amazon-linux-2.id
#   associate_public_ip_address = false
#   instance_type               = "t2.micro"
#   key_name                    = var.key_name
#   subnet_id                   = var.vpc.private_subnets[1]
#   vpc_security_group_ids      = [var.sg_priv_id]

#   tags = {
#     "Name" = "${var.namespace}-EC2-PRIVATE"
#   }
# }
