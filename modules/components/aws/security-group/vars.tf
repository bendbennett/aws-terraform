variable "security_group_rules_cidr_blocks" {
    type = "list"
    default = []
}

variable "security_group_rules_source_security_group_id" {
    type = "list"
    default = []
}

variable "security_group_rules_self" {
    type = "list"
    default = []
}

variable "source_security_group_ids" {
    type = "list"
    default = []
}

variable "vpc_id" {}
