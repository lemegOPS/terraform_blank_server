#----------- Global variables -----------#

variable "profile" {
  type = map(any)
  default = {
    dev   = "aws_own"
    stage = "aws_stage"
    prod  = "aws_own_prod"
  }
  description = "Use if you have a profile. More security decision. Use this map to separate env. in accounts"
}

variable "region" {
  type = map(any)
  default = {
    dev   = "us-east-1"
    stage = "ca-central-1"
    prod  = "eu-central-1"
  }
  description = "Use this map to separate env. in more cheaper ore close to your clients countries"
}

variable "tags" {
  type = map(any)
  default = {
    Owner       = "Alex"
    Project     = "Phoenix"
    Name        = "Service_name"
    Environment = "dev"
  }
  description = "Use this map of tags. Use to generate bucket name, names or resources, tags. See global_name in module"
}


#----------- Instance variables -----------#

variable "instance_type" {
  type = map(any)
  default = {
    dev   = "t2.micro"
    stage = "t2.small"
    prod  = "t2.2xlarge"
  }
  description = "Use this map of the instance type. Use to make our env more flexible"
}

variable "instance_amount" {
  type = map(any)
  default = {
    dev   = "1"
    stage = "2"
    prod  = "3"
  }
  description = "Use this map of the instance amount. Use to make our env more flexible"
}

variable "ami_image" {
  type = object({
    ami_owners       = list(string)
    ami_filter_value = list(string)
    ami_filter_name  = string
  })
  default = {
    ami_owners       = ["amazon"]
    ami_filter_value = ["amzn2-ami-hvm-*-x86_64-gp2"]
    ami_filter_name  = "name"
  }
  description = "Add owner and ami_name to search and choose most recent ami"
}


#----------- VPC variables -----------#

variable "cidr_block" {
  type = map(any)
  default = {
    external = "0.0.0.0/0"
    internal = "10.0.0.0/16"
  }
  description = "Cidr Block map. Use for network"
}

variable "sg_port" {
  type = map(any)
  default = {
    dev   = ["22", "80", "8080"]
    stage = ["22", "80"]
    prod  = ["22"]
  }
  description = "Ports for Security group. Also map for diferent env."
}
