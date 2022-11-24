variable "vpc_cidr" {
  type    = string
  description = "Enter the VPC CIDR Value."
  default = "172.31.0.0/16"
}

variable "public_cidr" {
  type    = string
  description = "Enter the VPC CIDR Value."
  default = "172.31.1.0/24"
}

variable "private_cidr" {
  type    = string
  description = "Enter the VPC CIDR Value."
  default = "172.31.2.0/24"
}

variable "public_cidrs" {
  type = list(string)
  default = ["172.31.1.0/24","172.31.4.0/24"]
}

variable "private_cidrs" {
  type    = list(string)
  default = ["172.31.2.0/24","172.31.6.0/24"]
}

variable "public_AZ" {
  type    = list(string)

  default = ["us-east-1a","us-east-1a"]
}

variable "private_AZ" {
  type    = list(string)

  default = ["us-east-1b","us-east-1b"]
}

variable "AMI_ID" {
  type    = string

  default = "ami-09d3b3274b6c5d4aa"
}

variable "instance_type" {
  type    = string

  default = "t2.micro"
}

variable "valume_size" {
  type    = string

  default = "8"
}