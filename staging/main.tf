variable "region" {}

variable "vpc_cidr" {}
variable "public_subnet" {}

variable "instance_type" {}
variable "ami_image_id" {}
variable "key_name" {}

provider "aws" {
  region = var.region
}

module "network" {
  source = "../modules/network"

  public_subnet = var.public_subnet
  vpc_cidr      = var.vpc_cidr
  vpc_id        = module.network.vpc_id
}

module "compute" {
  source = "../modules/compute"

  vpc_id                    = module.network.vpc_id
  security_group_web_id     = module.network.security_group_web_id
  security_group_ansible_id = module.network.security_group_ansible_id
  instance_type             = var.instance_type
  public_subnet_id          = module.network.public_subnet_id
  ami_image_id              = var.ami_image_id
  key_name                  = var.key_name
}