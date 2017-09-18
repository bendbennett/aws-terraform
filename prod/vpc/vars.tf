variable "cidr_block_vpc" {
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type = "list"
  default = [
    "eu-west-1a",
    "eu-west-1b",
    "eu-west-1c"
  ]
}

variable "cidr_blocks_public" {
  type = "list"
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "cidr_blocks_private" {
  type = "list"
  default = [
    "10.0.128.0/24",
    "10.0.129.0/24",
    "10.0.130.0/24"
  ]
}
