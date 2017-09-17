resource "aws_iam_instance_profile" "iam_instance_profile" {
  role = "${var.iam_role_name}"
}