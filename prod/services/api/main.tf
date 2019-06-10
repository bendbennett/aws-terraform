terraform {
  backend "local" {
    path = "state/terraform.tfstate"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../../vpc/state/terraform.tfstate"
  }
}

data "terraform_remote_state" "global" {
  backend = "local"

  config = {
    path = "../../../global/state/terraform.tfstate"
  }
}

module "api" {
  source = "../../../modules/infrastructure/services/api"

  security_group_rules_source_security_group_id_ec2_instance_web = "${var.security_group_rules_source_security_group_id_ec2_instance_web}"
  security_group_rules_cidr_blocks_ec2_instance_web = "${var.security_group_rules_cidr_blocks_ec2_instance_web}"
  security_group_rules_cidr_blocks_load_balancer_web = "${var.security_group_rules_cidr_blocks_load_balancer_web}"
  load_balancer_web = "${var.load_balancer_web}"
  ssl_certificate_id = "${var.ssl_certificate_id}"
  vpc_id = "${data.terraform_remote_state.vpc.outputs.vpc_id}"
  subnet_ids_public = "${data.terraform_remote_state.vpc.outputs.subnet_ids_public}"
  security_group_rules_source_security_group_id_ec2_instance_mongo = "${var.security_group_rules_source_security_group_id_ec2_instance_mongo}"
  security_group_rules_cidr_blocks_ec2_instance_mongo = "${var.security_group_rules_cidr_blocks_ec2_instance_mongo}"
  security_group_rules_self_ec2_instance_mongo = "${var.security_group_rules_source_security_group_id_ec2_instance_mongo}"
  iam_role_name = "${data.terraform_remote_state.global.outputs.iam_role_launch_configuration_name}"
  log_group = "${var.log_group}"

  ecs_cluster_name_mongo = "${var.ecs_cluster_name_mongo}"
  hosted_zone_id = "${data.terraform_remote_state.vpc.outputs.hosted_zone_id}"
  launch_configuration_mongo_user_data_template = "${file("templates/mongo_user_data.sh")}"
  launch_configuration_mongo = "${var.launch_configuration_mongo}"
  key_name = "${var.key_name}"
  autoscaling_group_mongo = "${var.autoscaling_group_mongo}"
  subnet_ids_private = "${data.terraform_remote_state.vpc.outputs.subnet_ids_private}"
  task_definition_mongo = "${var.task_definition_mongo}"
  task_definition_mongo_container_definitions = "${file("templates/mongo_task_definition_container_definitions.json")}"
  service_mongo = "${var.service_mongo}"

  ecs_cluster_name_web = "${var.ecs_cluster_name_web}"
  launch_configuration_web_user_data_template = "${file("templates/web_user_data.sh")}"
  launch_configuration_web = "${var.launch_configuration_web}"
  autoscaling_group_web = "${var.autoscaling_group_web}"
  task_definition_web = "${var.task_definition_web}"
  task_definition_web_container_definitions_template = "${file("templates/web_task_definition_container_definitions.json")}"
  service_web = "${var.service_web}"
  service_web_iam_role_arn = "${data.terraform_remote_state.global.outputs.iam_role_ecs_service_arn}"

  record_set_load_balancer_web = "${var.load_balancer_web_record_set}"

  hosted_zone_public_name = "${var.hosted_zone_public_name}"
  hosted_zone_public_id = "${var.hosted_zone_public_id}"
  hosted_zone_private_prefix = "${var.hosted_zone_private_prefix}"

  s3_template_bucket = "${var.s3_template_bucket}"
}
