variable "security_group_rules_cidr_blocks_load_balancer_web" { type = "list" }

variable "load_balancer_web" { type = "map" }

variable "security_group_rules_source_security_group_id_ec2_instance_web" { type = "list" }

variable "security_group_rules_cidr_blocks_ec2_instance_web" { type = "list" }

variable "security_group_rules_source_security_group_id_ec2_instance_mongo" { type = "list" }

variable "security_group_rules_cidr_blocks_ec2_instance_mongo" { type = "list" }

variable "security_group_rules_self_ec2_instance_mongo" { type = "list" }

variable "subnet_ids_public" { type = "list" }

variable "vpc_id" {}