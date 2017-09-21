output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "subnet_ids_public" {
  value = "${module.vpc.subnet_ids_public}"
}

output "subnet_ids_private" {
  value = "${module.vpc.subnet_ids_private}"
}

output "hosted_zone_id" {
  value = "${module.vpc.hosted_zone_id}"
}
