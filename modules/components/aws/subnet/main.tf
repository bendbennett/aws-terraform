resource "aws_subnet" "subnet" {
  count = "${length(var.cidr_blocks)}"

  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block = "${element(var.cidr_blocks, count.index)}"
  vpc_id = "${var.vpc_id}"
}

resource "aws_route_table" "route_table" {
  count = "${length(var.cidr_blocks)}"

  vpc_id = "${var.vpc_id}"
}

resource "aws_route" "route_public" {
  count = "${var.public_subnet ? length(var.cidr_blocks) : 0}"

  route_table_id = "${element(aws_route_table.route_table.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${var.internet_gateway_id}"
}

resource "aws_route" "route_private" {
  count = "${var.public_subnet ? 0 : length(var.cidr_blocks)}"

  route_table_id = "${element(aws_route_table.route_table.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${var.nat_gateway_ids[count.index]}"
}

resource "aws_route_table_association" "route_table_association" {
  count = "${length(var.cidr_blocks)}"

  route_table_id = "${element(aws_route_table.route_table.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.subnet.*.id, count.index)}"
}

resource "aws_eip" "eip" {
  count = "${var.public_subnet ? length(var.cidr_blocks) : 0}"
}

resource "aws_nat_gateway" "nat_gateway" {
  count = "${var.public_subnet ? length(var.cidr_blocks) : 0}"

  allocation_id = "${element(aws_eip.eip.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.subnet.*.id, count.index)}"
}
