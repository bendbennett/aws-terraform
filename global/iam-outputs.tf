output "iam_role_ecs_service_name" {
  value = "${module.iam-role-ecs.iam_role_name}"
}

output "iam_role_ecs_service_arn" {
  value = "${module.iam-role-ecs.iam_role_arn}"
}

output "iam_role_launch_configuration_name" {
  value = "${module.iam-role-launch-configuration.iam_role_name}"
}

output "iam_role_launch_configuration_arn" {
  value = "${module.iam-role-launch-configuration.iam_role_arn}"
}
