variable "cidr_block_vpc" {}

variable "availability_zones" { type = "list" default = [] }

variable "cidr_blocks_public" { type = "list" default = [] }

variable "cidr_blocks_private" { type = "list" default = [] }

variable "hosted_zone_private" { type = "map" }

variable "hosted_zone_private_prefix" {}

variable "hosted_zone_public_name" {}
