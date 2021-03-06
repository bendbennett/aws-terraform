resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block_vpc}"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
}
