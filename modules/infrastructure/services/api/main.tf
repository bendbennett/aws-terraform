module "security_group_load_balancer_web" {
  source = "../../../components/aws/security-group"

  security_group_rules_cidr_blocks = "${var.security_group_rules_cidr_blocks_load_balancer_web}"
  vpc_id = "${var.vpc_id}"
}

module "load_balancer_web" {
  source = "../../../components/aws/load-balancer"

  security_groups = ["${module.security_group_load_balancer_web.security_group_id}"]
  cross_zone_load_balancing = "${var.load_balancer_web["cross_zone_load_balancing"]}"
  name = "${var.load_balancer_web["name"]}"
  subnets = "${var.subnet_ids_public}"
}

module "security_group_ec2_instance_web" {
  source = "../../../components/aws/security-group"

  security_group_rules_source_security_group_id = "${var.security_group_rules_source_security_group_id_ec2_instance_web}"
  source_security_group_ids = ["${module.security_group_load_balancer_web.security_group_id}"]
  security_group_rules_cidr_blocks = "${var.security_group_rules_cidr_blocks_ec2_instance_web}"
  vpc_id = "${var.vpc_id}"
}

module "security_group_ec2_instance_mongo" {
  source = "../../../components/aws/security-group"

  security_group_rules_source_security_group_id = "${var.security_group_rules_source_security_group_id_ec2_instance_mongo}"
  source_security_group_ids = ["${module.security_group_ec2_instance_web.security_group_id}"]
  security_group_rules_cidr_blocks = "${var.security_group_rules_cidr_blocks_ec2_instance_mongo}"
  security_group_rules_self = "${var.security_group_rules_self_ec2_instance_mongo}"
  vpc_id = "${var.vpc_id}"
}

module "role_launch_configuration_instance_profile" {
  source = "../../../components/aws/iam-instance-profile"

  iam_role_name = "${var.iam_role_name}"
}

module "log_group" {
  source = "../../../components/aws/log-group"

  name = "${var.log_group["name"]}"
  retention_in_days = "${var.log_group["retention_in_days"]}"
}
