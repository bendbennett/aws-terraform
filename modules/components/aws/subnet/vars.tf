variable "availability_zones" { type = "list" }

variable "cidr_blocks" { type = "list" }

variable "internet_gateway_id" { default = "" }

variable "nat_gateway_ids" { type = "list" default = [] }

variable "public_subnet" {}

variable "vpc_id" {}
