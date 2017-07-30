// Provider
provider "aws" {
  region = "eu-west-1"
}

// Variables
variable "cidr_block_main" {
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type = "list"
  default = [
    "eu-west-1a",
    "eu-west-1b",
    "eu-west-1c"
  ]
}

variable "cidr_blocks_public" {
  type = "list"
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "cidr_blocks_private" {
  type = "list"
  default = [
    "10.0.128.0/24",
    "10.0.129.0/24",
    "10.0.130.0/24"
  ]
}

// Resources
resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block_main}"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table" "route_table_public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }
}

resource "aws_subnet" "subnet_public" {
  count = 3

  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block = "${element(var.cidr_blocks_public, count.index)}"
  vpc_id     = "${aws_vpc.vpc.id}"
}

resource "aws_route_table_association" "route_table_association_subnet_public" {
  count = 3

  route_table_id = "${aws_route_table.route_table_public.id}"
  subnet_id = "${element(aws_subnet.subnet_public.*.id, count.index)}"
}

resource "aws_eip" "eip" {
  count = 3
}

resource "aws_nat_gateway" "nat_gateway_subnet_public" {
  count = 3

  allocation_id = "${element(aws_eip.eip.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.subnet_public.*.id, count.index)}"

  depends_on = ["aws_internet_gateway.internet_gateway"]
}

resource "aws_route_table" "route_table_private" {
  count = 3

  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat_gateway_subnet_public.*.id, count.index)}"
  }
}

resource "aws_subnet" "subnet_private" {
  count = 3

  availability_zone =  "${element(var.availability_zones, count.index)}"
  cidr_block = "${element(var.cidr_blocks_private, count.index)}"
  vpc_id     = "${aws_vpc.vpc.id}"
}

resource "aws_route_table_association" "route_table_association_private" {
  count = 3

  route_table_id = "${element(aws_route_table.route_table_private.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.subnet_private.*.id, count.index)}"
}
