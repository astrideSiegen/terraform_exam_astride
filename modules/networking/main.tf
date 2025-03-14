
#create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.network_name}-VPC"
  }
}

#create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.network_name}-igw"
  }
}

#create subnet pour az1 et az2 for HA
resource "aws_subnet" "public_sn_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pubsn_cidr[0]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "public_sn_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pubsn_cidr[1]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "public_subnet_2"
  }
}

resource "aws_subnet" "private_sn_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.privat_sn_cidr[0]
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "private_sn_1"
  }
}


resource "aws_subnet" "private_sn_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.privat_sn_cidr[1]
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "private_sn_2"
  }
}

#route table Creation
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.cidr_all
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_routetable"
  }
}

# route table nat_gat_1
resource "aws_route_table" "private_rt_1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.cidr_all
    nat_gateway_id = aws_nat_gateway.nat_1.id
  }
  tags = {
    Name = "private_routetable_1"
  }
}

# route table nat_gat_2
resource "aws_route_table" "private_rt_2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.cidr_all
    nat_gateway_id = aws_nat_gateway.nat_2.id
  }
  tags = {
    Name = "private_routetable_2"
  }
}


#table associative réseau publique 1 et 2
# Les sous-réseaux publics utilisent cette table de routage pour accéder à Internet
resource "aws_route_table_association" "public_rta_1" {
  subnet_id      = aws_subnet.public_sn_1.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_rta_2" {
  subnet_id      = aws_subnet.public_sn_2.id
  route_table_id = aws_route_table.public_rt.id
}

#table associative réseau privée 1 et 2
resource "aws_route_table_association" "private_rta_1" {
  subnet_id      = aws_subnet.private_sn_1.id
  route_table_id = aws_route_table.private_rt_1.id
}

resource "aws_route_table_association" "private_rta_2" {
  subnet_id      = aws_subnet.private_sn_2.id
  route_table_id = aws_route_table.private_rt_2.id
}


#Nat Gateway, Permet aux sous-réseaux privés de se connecter à Internet sans être exposés.
#NAT Gateway and EIP Creation
resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.eip_1.id
  subnet_id     = aws_subnet.public_sn_1.id

  tags = {
    Name = "nat_gw_1"
  }
}

resource "aws_eip" "eip_1" {
  tags = {
    Name = "my_eip_1"
  }
}

resource "aws_nat_gateway" "nat_2" {
  allocation_id = aws_eip.eip_2.id
  subnet_id     = aws_subnet.public_sn_2.id

  tags = {
    Name = "nat_gw_2"
  }
}

resource "aws_eip" "eip_2" {
  tags = {
    Name = "my_eip_2"
  }
}
