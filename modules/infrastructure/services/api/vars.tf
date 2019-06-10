variable "security_group_rules_cidr_blocks_load_balancer_web" {
    type = "list"
}

variable "load_balancer_web" {
    type = "map"
}

variable "ssl_certificate_id" {}

variable "security_group_rules_source_security_group_id_ec2_instance_web" {
    type = "list"
}

variable "security_group_rules_cidr_blocks_ec2_instance_web" {
    type = "list"
}

variable "security_group_rules_source_security_group_id_ec2_instance_mongo" {
    type = "list"
}

variable "security_group_rules_cidr_blocks_ec2_instance_mongo" {
    type = "list"
}

variable "security_group_rules_self_ec2_instance_mongo" {
    type = "list"
}

variable "subnet_ids_public" {
    type = "list"
}

variable "vpc_id" {}

variable "iam_role_name" {}

variable "log_group" {
    type = "map"
}

variable "ecs_cluster_name_mongo" {}

variable "hosted_zone_id" {}

variable "launch_configuration_mongo_user_data_template" {}

variable "launch_configuration_mongo" {
    type = "map"
}

variable "key_name" {}

variable "autoscaling_group_mongo" {
    type = "map"
}

variable "subnet_ids_private" {
    type = "list"
}

variable "task_definition_mongo" {
    type = "map"
}

variable "task_definition_mongo_container_definitions" {}

variable "service_mongo" {
    type = "map"
}

variable "ecs_cluster_name_web" {}

variable "launch_configuration_web_user_data_template" {}

variable "launch_configuration_web" {
    type = "map"
}

variable "autoscaling_group_web" {
    type = "map"
}

variable "task_definition_web" {
    type = "map"
}

variable "task_definition_web_container_definitions_template" {}

variable "service_web" {
    type = "map"
}

variable "service_web_iam_role_arn" {}

variable "record_set_load_balancer_web" {
    type="map"
}

variable "hosted_zone_public_name" {}

variable "hosted_zone_public_id" {}

variable "s3_template_bucket" {}

variable "hosted_zone_private_prefix" {}
