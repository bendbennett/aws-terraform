resource "aws_security_group" "security_group" {
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "security_group_rule_cidr_blocks" {
  count = "${length(var.security_group_rules_cidr_blocks)}"

  cidr_blocks = ["${lookup(var.security_group_rules_cidr_blocks[count.index], "cidr_blocks")}"]
  from_port = "${lookup(var.security_group_rules_cidr_blocks[count.index], "from_port")}"
  protocol = "${lookup(var.security_group_rules_cidr_blocks[count.index], "protocol")}"
  security_group_id = "${aws_security_group.security_group.id}"
  to_port = "${lookup(var.security_group_rules_cidr_blocks[count.index], "to_port")}"
  type = "${lookup(var.security_group_rules_cidr_blocks[count.index], "type")}"
}

resource "aws_security_group_rule" "security_group_rule_source_security_group_id" {
  count = "${length(var.security_group_rules_source_security_group_id)}"

  from_port = "${lookup(var.security_group_rules_source_security_group_id[count.index], "from_port")}"
  protocol = "${lookup(var.security_group_rules_source_security_group_id[count.index], "protocol")}"
  security_group_id = "${aws_security_group.security_group.id}"
  source_security_group_id = "${var.source_security_group_ids[count.index]}"
  to_port = "${lookup(var.security_group_rules_source_security_group_id[count.index], "to_port")}"
  type = "${lookup(var.security_group_rules_source_security_group_id[count.index], "type")}"
}

resource "aws_security_group_rule" "security_group_rule_self" {
  count = "${length(var.security_group_rules_self)}"

  from_port = "${lookup(var.security_group_rules_source_security_group_id[count.index], "from_port")}"
  protocol = "${lookup(var.security_group_rules_source_security_group_id[count.index], "protocol")}"
  security_group_id = "${aws_security_group.security_group.id}"
  self = true
  to_port = "${lookup(var.security_group_rules_source_security_group_id[count.index], "to_port")}"
  type = "${lookup(var.security_group_rules_source_security_group_id[count.index], "type")}"
}
