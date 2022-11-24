/*
data "aws_ami" "Amazon_linux" {
  most_recent = true
  owners = ["137112412989"]

  filter {
    name   = "name"
    values = ["amazon/amzn2-ami-kernel-5.10-hvm-2.0.20221004.0-x86_64-gp2"]
  }

}
*/

resource "aws_instance" "terraform_ec2_instance" {
  //count = var.instance_count
  ami           = var.AMI_ID.id
  instance_type = var.instance_type
  key_name      = "aws-devops"

  tags = {
    Name = "terraform_ec2_instance"
  }

  vpc_security_group_ids = [aws_security_group.terrafrom_security_group.id]
  subnet_id              = aws_subnet.terraform_public_subnet[0].id
  
  root_block_device {
    volume_size = "8"
  }
}
