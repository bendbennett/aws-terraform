terraform {
  backend "local" {
    path = "state/terraform.tfstate"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "local"

  config {
    path = "../../vpc/state/terraform.tfstate"
  }
}

data "terraform_remote_state" "iam" {
  backend = "local"

  config {
    path = "../../../global/iam/state/terraform.tfstate"
  }
}

module "api" {
  source = "../../../modules/infrastructure/services/api"

  security_group_rules_source_security_group_id_ec2_instance_web = "${var.security_group_rules_source_security_group_id_ec2_instance_web}"
  security_group_rules_cidr_blocks_ec2_instance_web = "${var.security_group_rules_cidr_blocks_ec2_instance_web}"
  security_group_rules_cidr_blocks_load_balancer_web = "${var.security_group_rules_cidr_blocks_load_balancer_web}"
  load_balancer_web = "${var.load_balancer_web}"
  ssl_certificate_id = "${var.ssl_certificate_id}"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
  subnet_ids_public = "${data.terraform_remote_state.vpc.subnet_ids_public}"
  security_group_rules_source_security_group_id_ec2_instance_mongo = "${var.security_group_rules_source_security_group_id_ec2_instance_mongo}"
  security_group_rules_cidr_blocks_ec2_instance_mongo = "${var.security_group_rules_cidr_blocks_ec2_instance_mongo}"
  security_group_rules_self_ec2_instance_mongo = "${var.security_group_rules_source_security_group_id_ec2_instance_mongo}"
  iam_role_name = "${data.terraform_remote_state.iam.iam_role_launch_configuration_name}"
  log_group = "${var.log_group}"
  ecs_cluster_name = "${var.ecs_cluster_name}"
  launch_configuration_mongo_user_data_template = "${file("mongo_user_data.sh")}"
  launch_configuration_mongo = "${var.launch_configuration_mongo}"
  key_name = "${var.key_name}"
  autoscaling_group_mongo = "${var.autoscaling_group_mongo}"
  subnet_ids_private = "${data.terraform_remote_state.vpc.subnet_ids_private}"
}
