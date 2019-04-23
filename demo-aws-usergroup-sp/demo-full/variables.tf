## variaveis - serão carregadas do arquivo terraform.tfvars
variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {

  default = "us-east-1"
}
variable "aws_availability_zone" {
  default = "us-east-1c"
}

variable "environment" {
  default = "demo"
}

variable "vpc_cidr_block" {
  default = "10.100.0.0/24"
}

variable "route_cidr_block" {
  default = "0.0.0.0/0"
}

variable "subnet_cidr_block" {
  default = "10.100.0.0/24"
}

variable "ami" {
  default = "ami-0a313d6098716f372"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "terraform-user"
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = "10"
}

