output "load_balancer_name" {
  value = "${aws_elb.load_balancer.name}"
}

output "load_balancer_dns_name" {
  value = "${aws_elb.load_balancer.dns_name}"
}
