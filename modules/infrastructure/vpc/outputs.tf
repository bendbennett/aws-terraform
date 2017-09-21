output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "subnet_ids_public" {
  value = "${module.subnet-public.subnet_ids}"
}

output "subnet_ids_private" {
  value = "${module.subnet-private.subnet_ids}"
}

output "hosted_zone_id" {
  value = "${module.hosted-zone-private.hosted_zone_id}"
}
