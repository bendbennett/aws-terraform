terraform {
  backend "local" {
    path = "state/terraform.tfstate"
  }
}

module "vpc" {
  source = "../../modules/infrastructure/vpc"

  availability_zones = "${var.availability_zones}"
  cidr_blocks_private = "${var.cidr_blocks_private}"
  cidr_blocks_public = "${var.cidr_blocks_public}"
  cidr_block_vpc = "${var.cidr_block_vpc}"
  hosted_zone_private = "${var.hosted_zone_private}"
}
