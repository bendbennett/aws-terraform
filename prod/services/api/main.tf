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

module "security-group" "security_group_load_balancer_web" {
  source = "../../../modules/aws/security-group"

  security_group_rules_cidr_blocks = "${var.security_group_rules_cidr_blocks_load_balancer_web}"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
}

module "load-balancer" "load_balancer_web" {
  source = "../../../modules/aws/load-balancer"

  security_groups = ["${module.security-group.security_group_id}"]
  cross_zone_load_balancing = "true"
  name = "load-balancer-web"
  subnets = "${data.terraform_remote_state.vpc.subnet_ids_public}"
}
