resource "aws_security_group" "security_group_load_balancer_web" {
  vpc_id = "${var.vpc_id}"
}
