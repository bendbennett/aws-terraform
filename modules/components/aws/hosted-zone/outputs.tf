output "hosted_zone_id" {
  value = "${aws_route53_zone.route53_zone.id}"
}