resource "aws_subnet" "subnet_private" {
  count = "${length(var.cidr_blocks_private)}"

  availability_zone =  "${element(var.availability_zones, count.index)}"
  cidr_block = "${element(var.cidr_blocks_private, count.index)}"
  vpc_id = "${var.vpc_id}"
}

resource "aws_route_table" "route_table" {
  count = "${length(var.cidr_blocks_private)}"

  vpc_id = "${var.vpc_id}"
}

resource "aws_route" "route" {
  count = "${length(var.cidr_blocks_private)}"

  route_table_id = "${element(aws_route_table.route_table.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${var.nat_gateway_ids[count.index]}"
}

resource "aws_route_table_association" "route_table_association_private" {
  count = "${length(var.cidr_blocks_private)}"

  route_table_id = "${element(aws_route_table.route_table.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.subnet_private.*.id, count.index)}"
}
