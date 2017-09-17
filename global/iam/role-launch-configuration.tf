terraform {
  backend "local" {
    path = "state/terraform.tfstate"
  }
}

data "aws_iam_policy_document" "iam_policy_document_iam_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "iam_policy_document_iam_role_policy" {
  statement {
    actions = [
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:Submit*"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }

  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:GetHostedZone",
      "route53:ListResourceRecordSets"
    ]
    resources = [
      "arn:aws:route53:::*"
    ]
  }

  statement {
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }
}

resource "aws_iam_role_policy" "iam_role_policy" {
  policy = "${data.aws_iam_policy_document.iam_policy_document_iam_role_policy.json}"
  role = "${aws_iam_role.iam_role.id}"
}

resource "aws_iam_role" "iam_role" {
  assume_role_policy = "${data.aws_iam_policy_document.iam_policy_document_iam_role.json}"
}
