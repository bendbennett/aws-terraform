terraform {
  backend "local" {
    path = "state/terraform.tfstate"
  }
}

module "iam-role-ecs" {
  source = "../modules/components/aws/iam-role"

  role_policy_identifiers = "${var.ecs_role_policy_identifiers}"
  policy_actions_resources = "${file("files/ecs_policy_actions_resources.json")}"
}

module "iam-role-launch-configuration" {
  source = "../modules/components/aws/iam-role"

  role_policy_identifiers = "${var.launch_configuration_role_policy_identifiers}"
  policy_actions_resources = "${file("files/launch_configuration_policy_actions_resources.json")}"
}
