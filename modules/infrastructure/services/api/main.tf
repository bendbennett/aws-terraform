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

module "ecs_cluster_mongo" {
  source = "../../../components/aws/ecs-cluster"

  name = "${var.ecs_cluster_name}"
}

data "template_file" "launch_configuration_mongo_user_data" {
  template = "${var.launch_configuration_mongo_user_data_template}"

  vars {
    cluster_id = "${module.ecs_cluster_mongo.ecs_cluster_id}"
  }
}

module "launch_configuration_autoscaling_group_mongo" {
  source = "../../../components/aws/launch-configuration-autoscaling-group"

  associate_public_ip_address = "${var.launch_configuration_mongo["associate_public_ip_address"]}"
  iam_instance_profile = "${module.role_launch_configuration_instance_profile.iam_instance_profile_id}"
  image_id = "${var.launch_configuration_mongo["image_id"]}"
  instance_type = "${var.launch_configuration_mongo["instance_type"]}"
  key_name = "${var.key_name}"
  security_groups = ["${module.security_group_ec2_instance_mongo.security_group_id}"]
  user_data = "${data.template_file.launch_configuration_mongo_user_data.rendered}"

  desired_capacity = "${var.autoscaling_group_mongo["desired_capacity"]}"
  health_check_type = "${var.autoscaling_group_mongo["health_check_type"]}"
  max_size = "${var.autoscaling_group_mongo["max_size"]}"
  min_size = "${var.autoscaling_group_mongo["min_size"]}"
  vpc_zone_identifier =  "${var.subnet_ids_private}"
}
