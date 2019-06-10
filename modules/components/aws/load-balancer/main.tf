resource "aws_elb" "load_balancer" {
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "${var.ssl_certificate_id}"
  }
  cross_zone_load_balancing = "${var.cross_zone_load_balancing}"
  name = "${var.name}"
  security_groups = "${var.security_groups}"
  subnets = "${var.subnets}"
}
