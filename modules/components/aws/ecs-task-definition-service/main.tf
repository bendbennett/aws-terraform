resource "aws_ecs_task_definition" "ecs_task_definition" {
  container_definitions = "${var.container_definitions}"
  family = "${var.family}"
}

resource "aws_ecs_service" "ecs_service" {
  cluster = "${var.cluster_id}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  desired_count = "${var.desired_count}"
//  iam_role = "${var.iam_role_arn}"
  name = "${var.name}"
  task_definition = "${aws_ecs_task_definition.ecs_task_definition.arn}"
}
