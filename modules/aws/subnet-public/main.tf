resource "aws_subnet" "subnet" {
  count = "${length(var.cidr_blocks_public)}"

  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block = "${element(var.cidr_blocks_public, count.index)}"
  vpc_id = "${var.vpc_id}"
}

resource "aws_route_table" "route_table" {
  vpc_id = "${var.vpc_id}"
}

resource "aws_route" "route" {
  route_table_id = "${aws_route_table.route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${var.internet_gateway_id}"
}

resource "aws_route_table_association" "route_table_association" {
  count = "${length(var.cidr_blocks_public)}"

  route_table_id = "${aws_route_table.route_table.id}"
  subnet_id = "${element(aws_subnet.subnet.*.id, count.index)}"
}

resource "aws_eip" "eip" {
  count = "${length(var.cidr_blocks_public)}"
}

resource "aws_nat_gateway" "nat_gateway" {
  count = "${length(var.cidr_blocks_public)}"

  allocation_id = "${element(aws_eip.eip.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.subnet.*.id, count.index)}"
}
