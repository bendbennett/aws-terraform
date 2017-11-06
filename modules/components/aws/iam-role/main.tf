data "aws_iam_policy_document" "iam_policy_document_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type = "Service"
      identifiers = "${var.role_policy_identifiers}"
    }
  }
}

// Using json snippets rather than "data" with variables owing to interpolation issues (see https://github.com/hashicorp/terraform/issues/8047)
resource "aws_iam_role_policy" "iam_role_policy" {
  policy = "${var.policy_actions_resources}"
  role = "${aws_iam_role.iam_role.id}"
}

resource "aws_iam_role" "iam_role" {
  assume_role_policy = "${data.aws_iam_policy_document.iam_policy_document_role_policy.json}"
}
