resource "aws_elb" "load_balancer" {
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  cross_zone_load_balancing = "${var.cross_zone_load_balancing}"
  name = "${var.name}"
  security_groups = ["${var.security_groups}"]
  subnets = ["${var.subnets}"]
}
