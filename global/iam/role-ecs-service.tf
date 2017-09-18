terraform {
  backend "local" {
    path = "state/terraform.tfstate"
  }
}

data "aws_iam_policy_document" "iam_policy_document_iam_role_ecs_service" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type = "Service"
      identifiers = [
        "ecs.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "iam_policy_document_iam_role_policy_ecs_service" {
  statement {
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy" "iam_role_policy_ecs_service" {
  policy = "${data.aws_iam_policy_document.iam_policy_document_iam_role_policy_ecs_service.json}"
  role = "${aws_iam_role.iam_role_ecs_service.id}"
}

resource "aws_iam_role" "iam_role_ecs_service" {
  assume_role_policy = "${data.aws_iam_policy_document.iam_policy_document_iam_role_ecs_service.json}"
}
