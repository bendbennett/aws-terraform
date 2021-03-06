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

variable "load_balancer_web" {
  type = "map"
  default = {
    cross_zone_load_balancing = true
    name = "load-balancer-web"
  }
}

variable "security_group_rules_source_security_group_id_ec2_instance_web" {
  type = "list"
  default = [
    {
      from_port = 80,
      protocol = "tcp"
      to_port = 80,
      type = "ingress"
    }
  ]
}

variable "security_group_rules_cidr_blocks_ec2_instance_web" {
  type = "list"
  default = [
    {
      cidr_blocks = "0.0.0.0/0",
      from_port = 0,
      protocol = "-1"
      to_port = 0,
      type = "egress"
    }
  ]
}

variable "security_group_rules_source_security_group_id_ec2_instance_mongo" {
  type = "list"
  default = [
    {
      from_port = 27017,
      protocol = "tcp"
      to_port = 27017,
      type = "ingress"
    }
  ]
}

variable "security_group_rules_cidr_blocks_ec2_instance_mongo" {
  type = "list"
  default = [
    {
      cidr_blocks = "0.0.0.0/0",
      from_port = 0,
      protocol = "-1"
      to_port = 0,
      type = "egress"
    }
  ]
}

variable "log_group" {
  type = "map"
  default = {
    name = "symfony-api-swagger-jwt"
    retention_in_days = 3
  }
}

variable "ecs_cluster_name_mongo" {
  default = "cluster-mongo"
}

variable "launch_configuration_mongo" {
  type = "map"
  default = {
    associate_public_ip_address = false
    image_id = "ami-8fcc32f6"
    instance_type = "t2.micro"
  }
}

variable "autoscaling_group_mongo" {
  type = "map"
  default = {
    desired_capacity = 3
    health_check_type = "EC2"
    max_size = 3
    min_size = 1
  }
}

variable "task_definition_mongo" {
  type = "map"
  default = {
    family = "mongo"
  }
}

variable "service_mongo" {
  type = "map"
  default = {
    deployment_minimum_healthy_percent = 50
    desired_count = 3
    load_balancer = false
    name = "mongo"
  }
}

variable "ecs_cluster_name_web" {
  default = "cluster-web"
}

variable "launch_configuration_web" {
  type = "map"
  default = {
    associate_public_ip_address = false
    image_id = "ami-8fcc32f6"
    instance_type = "t2.micro"
  }
}

variable "autoscaling_group_web" {
  type = "map"
  default = {
    desired_capacity = 3
    health_check_type = "EC2"
    max_size = 3
    min_size = 1
  }
}

variable "task_definition_web" {
  type = "map"
  default = {
    family = "web"
  }
}

variable "service_web" {
  type = "map"
  default = {
    container_name = "nginx"
    container_port = 80
    deployment_minimum_healthy_percent = 50
    desired_count = 3
    load_balancer = true
    name = "web"
  }
}

variable "load_balancer_web_record_set" {
  type = "map"
  default = {
    ttl = 60
    type = "CNAME"
  }
}
