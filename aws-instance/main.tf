locals {
  global_name  = replace("${var.tags["Project"]}-${var.tags["Environment"]}-${var.tags["Name"]}", "-", "_")
  propper_tags = merge(var.tags, { Name = "${local.global_name}" })
  bucket_name  = replace("${var.tags["Project"]}-${var.tags["Environment"]}-${var.tags["Name"]}", "_", "-")
}

module "aws-instance" {
  source             = "./modules/aws-instance"
  instance_type      = var.instance_type
  instance_amount    = var.instance_amount
  tags               = var.tags
  ami_image          = var.ami_image
  vpc_security_group = module.aws-security-group.security_group_id
  global_name        = local.global_name
  private_key_name   = module.aws-private-key.private_key_name
}


module "aws-private-key" {
  source       = "./modules/aws-private-key"
  propper_tags = local.propper_tags
  global_name  = local.global_name
}

module "aws-s3" {
  source      = "./modules/aws-s3"
  tags        = var.tags
  region      = var.region
  profile     = var.profile
  global_name = local.global_name
  bucket_name = local.bucket_name
  depends_on  = [module.aws-instance]
}

module "aws-eip" {
  source      = "./modules/aws-eip"
  tags        = var.tags
  global_name = local.global_name
  servers     = module.aws-instance.servers
}

module "aws-security-group" {
  source       = "./modules/aws-sg"
  vpc_id       = module.aws-vpc.vpc_id
  sg_port      = var.sg_port
  cidr_block   = var.cidr_block
  propper_tags = local.propper_tags
  global_name  = local.global_name
  tags         = var.tags
}

module "aws-vpc" {
  source = "./modules/aws-vpc"
}

/*
terraform {
  backend "s3" {
    bucket         = module.aws-s3.bucket_name
    key            = module.aws-s3.key
    region         = var.region
    dynamodb_table = lookup(var.region, var.tags["Environment"])
  }
}
*/