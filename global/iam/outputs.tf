output "iam_role_launch_configuration_name" {
  value = "${aws_iam_role.iam_role_launch_configuration.name}"
}

output "iam_role_ecs_service" {
  value = "${aws_iam_role.iam_role_ecs_service.name}"
}

output "iam_role_ecs_service_arn" {
  value = "${aws_iam_role.iam_role_ecs_service.arn}"
}
