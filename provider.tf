provider "aws" {
  region  = lookup(var.region, var.tags["Environment"])
  profile = lookup(var.profile, var.tags["Environment"])
}