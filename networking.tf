data "aws_availability_zones" "available" {}

resource "aws_vpc" "terraform_Aws_VPC" {
  cidr_block           = var.vpc_cidr
  //cidr_block           = 171.31.0.0/16
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "terraform_Aws_VPC"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "Terraform_IGW" {
  vpc_id = aws_vpc.terraform_Aws_VPC.id

  tags = {
    Name = "Terraform_IGW"
  }
}

resource "aws_route_table" "terraform_public_Aws_RT" {
  vpc_id = aws_vpc.terraform_Aws_VPC.id

  tags = {
    Name = "terraform_public_Aws_RT"
  }
}

resource "aws_route_table" "terraform_Private_Aws_RT" {
  vpc_id = aws_vpc.terraform_Aws_VPC.id
  

  tags = {
    Name = "terraform_Private_Aws_RT"
  }
}

resource "aws_route" "terraform_Pub_rout" {
  route_table_id            =aws_route_table.terraform_public_Aws_RT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.Terraform_IGW.id
}



resource "aws_subnet" "terraform_public_subnet" {
  count = 2
  vpc_id     = aws_vpc.terraform_Aws_VPC.id
  cidr_block = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  //availability_zone = "us-east-1a"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  //availability_zone = var.private_AZ[count.index]

  tags = {
    Name = "terraform_public_subnet"
  }
}

resource "aws_subnet" "terraform_private_subnet" {
  count = 2
  vpc_id     = aws_vpc.terraform_Aws_VPC.id
  cidr_block = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  //availability_zone = "us-east-1b"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  //availability_zone = var.public_AZ[count.index]


  tags = {
    Name = "terraform_private_subnet"
  }
}

resource "aws_route_table_association" "terraform_public_subnet_association" {
  count          = 2
  subnet_id      = aws_subnet.terraform_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.terraform_public_Aws_RT.id
}

resource "aws_route_table_association" "terraform_private_subnet_association" {
  count          = 2
  subnet_id      = aws_subnet.terraform_private_subnet.*.id[count.index]
  route_table_id = aws_route_table.terraform_Private_Aws_RT.id
}

resource "aws_security_group" "terrafrom_security_group" {
  name        = "terrafrom_security_group"
  description = "security group for public instance"
  vpc_id      = aws_vpc.terraform_Aws_VPC.id
}

resource "aws_security_group_rule" "ingress_all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terrafrom_security_group.id
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  to_port           = 22
  from_port         = 22
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terrafrom_security_group.id
}

resource "aws_vpc_endpoint" "VPC_Gateway_Endpoint" {
  vpc_id       = aws_vpc.terraform_Aws_VPC.id
  service_name = "com.amazonaws.us-east-1.s3"
  route_table_ids = [ aws_route_table.terraform_Private_Aws_RT.id ]
}

