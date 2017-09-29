resource "aws_route53_record" "route53_record" {
  name = "${var.name}"
  records = ["${var.records}"]
  ttl = "${var.ttl}"
  type = "${var.type}"
  zone_id = "${var.zone_id}"
}
