terraform {
  backend "local" {
    path = "state/terraform.tfstate"
  }
}

module "vpc" {
  source = "../../modules/aws/vpc"

  cidr_block_vpc = "${var.cidr_block_vpc}"
}

module "subnet-public" {
  source = "../../modules/aws/subnet-public"

  availability_zones = "${var.availability_zones}"
  cidr_blocks_public = "${var.cidr_blocks_public}"
  internet_gateway_id = "${module.vpc.internet_gateway_id}"
  vpc_id = "${module.vpc.vpc_id}"
}

module "subnet-private" {
  source = "../../modules/aws/subnet-private"

  availability_zones = "${var.availability_zones}"
  cidr_blocks_private = "${var.cidr_blocks_private}"
  nat_gateway_ids = "${module.subnet-public.nat_gateway_ids}"
  vpc_id = "${module.vpc.vpc_id}"
}
