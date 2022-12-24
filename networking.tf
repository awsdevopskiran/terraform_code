resource "aws_vpc" "terraform_Aws_VPC" {
  cidr_block           = "12.0.0.0/16"
  
  tags = {
    Name = "terraform_Aws_VPC"
   }
}


