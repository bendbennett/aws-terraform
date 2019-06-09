resource "aws_route53_zone" "route53_zone" {
  force_destroy = "${var.force_destroy}"
  name = "${var.name}"
  vpc {
    vpc_id = "${var.vpc_id}"
  }
}
