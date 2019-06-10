resource "aws_launch_configuration" "launch_configuration" {
  associate_public_ip_address = "${var.associate_public_ip_address}"
  iam_instance_profile = "${var.iam_instance_profile}"
  image_id = "${var.image_id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  security_groups = "${var.security_groups}"
  user_data = "${var.user_data}"
}

resource "aws_autoscaling_group" "autoscaling_group" {
  desired_capacity = "${var.desired_capacity}"
  health_check_type = "${var.health_check_type}"
  launch_configuration = "${aws_launch_configuration.launch_configuration.name}"
  max_size = "${var.max_size}"
  min_size = "${var.min_size}"
  vpc_zone_identifier = "${var.vpc_zone_identifier}"
}