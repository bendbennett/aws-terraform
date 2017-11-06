variable "ecs_role_policy_identifiers" {
  type = "list"
  default = [
    "ecs.amazonaws.com"
  ]
}

variable "launch_configuration_role_policy_identifiers" {
  type = "list"
  default = [
    "ec2.amazonaws.com"
  ]
}
