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
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
  subnet_ids_public = "${data.terraform_remote_state.vpc.subnet_ids_public}"
  security_group_rules_source_security_group_id_ec2_instance_mongo = "${var.security_group_rules_source_security_group_id_ec2_instance_mongo}"
  security_group_rules_cidr_blocks_ec2_instance_mongo = "${var.security_group_rules_cidr_blocks_ec2_instance_mongo}"
  security_group_rules_self_ec2_instance_mongo = "${var.security_group_rules_source_security_group_id_ec2_instance_mongo}"
  iam_role_name = "${data.terraform_remote_state.iam.iam_role_name}"
}
