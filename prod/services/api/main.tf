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

module "security-group" {
  source = "../../../modules/aws/security-group"

  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
}
