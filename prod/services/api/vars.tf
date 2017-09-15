provider "aws" {
  region = "eu-west-1"
}

variable "security_group_rules_cidr_blocks_load_balancer_web" {
  type = "list"
  default = [
    {
      cidr_blocks = "0.0.0.0/0",
      from_port = 80,
      protocol = "tcp"
      to_port = 80,
      type = "ingress"
    },
    {
      cidr_blocks = "0.0.0.0/0",
      from_port = 443,
      protocol = "tcp"
      to_port = 443,
      type = "ingress"
    },
    {
      cidr_blocks = "0.0.0.0/0",
      from_port = 0,
      protocol = "-1"
      to_port = 0,
      type = "egress"
    }
  ]
}
