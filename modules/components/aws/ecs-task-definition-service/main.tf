resource "aws_ecs_task_definition" "ecs_task_definition" {
  container_definitions = "${var.container_definitions}"
  family = "${var.family}"
}

resource "aws_ecs_service" "ecs_service" {
  count = "${var.load_balancer ? 0 : 1}"

  cluster = "${var.cluster_id}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  desired_count = "${var.desired_count}"
  name = "${var.name}"
  task_definition = "${aws_ecs_task_definition.ecs_task_definition.arn}"
}

resource "aws_ecs_service" "ecs_service_load_balancer" {
  count = "${var.load_balancer ? 1 : 0}"

  cluster = "${var.cluster_id}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  desired_count = "${var.desired_count}"
  iam_role = "${var.iam_role_arn}"
  name = "${var.name}"
  task_definition = "${aws_ecs_task_definition.ecs_task_definition.arn}"

  load_balancer {
    elb_name       = "${var.load_balancer_name}"
    container_name = "${var.container_name}"
    container_port = "${var.container_port}"
  }
}
