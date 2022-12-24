

resource "aws_vpc" "terraform_Aws_VPC" {
#   cidr_block           = var.vpc_cidr
  cidr_block           = 171.31.0.0/16
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "terraform_Aws_VPC"
   }
}
