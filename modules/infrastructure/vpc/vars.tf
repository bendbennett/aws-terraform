variable "cidr_block_vpc" {}

variable "availability_zones" { type = "list" default = [] }

variable "cidr_blocks_public" { type = "list" default = [] }

variable "cidr_blocks_private" { type = "list" default = [] }
