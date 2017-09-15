output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "internet_gateway_id" {
  value = "${module.vpc.internet_gateway_id}"
}

output "nat_gateway_ids" {
  value = "${module.subnet-public.nat_gateway_ids}"
}

output "subnet_ids_public" {
  value = "${module.subnet-public.subnet_ids}"
}
