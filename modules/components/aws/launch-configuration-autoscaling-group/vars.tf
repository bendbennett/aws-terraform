// Launch Configuration
variable "associate_public_ip_address" {}

variable "iam_instance_profile" {}

variable "image_id" {}

variable "instance_type" {}

variable "key_name" {}

variable "security_groups" { type = "list" }

variable user_data {}

// Autoscaling Group
variable desired_capacity {}

variable health_check_type {}

variable max_size {}

variable min_size {}

variable vpc_zone_identifier { type = "list" }
