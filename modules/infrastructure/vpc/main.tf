module "vpc" {
  source = "../../components/aws/vpc"

  cidr_block_vpc = "${var.cidr_block_vpc}"
}

module "subnet-public" {
  source = "../../components/aws/subnet"

  availability_zones = "${var.availability_zones}"
  cidr_blocks = "${var.cidr_blocks_public}"
  internet_gateway_id = "${module.vpc.internet_gateway_id}"
  public_subnet = true
  vpc_id = "${module.vpc.vpc_id}"
}

module "subnet-private" {
  source = "../../components/aws/subnet"

  availability_zones = "${var.availability_zones}"
  cidr_blocks = "${var.cidr_blocks_private}"
  nat_gateway_ids = "${module.subnet-public.nat_gateway_ids}"
  public_subnet = false
  vpc_id = "${module.vpc.vpc_id}"
}
