// Task Definition
variable container_definitions {}

variable family {}

// Service
variable cluster_id {}

variable container_name {
    default = ""
}

variable container_port {
    default = ""
}

variable deployment_minimum_healthy_percent {}

variable desired_count {}

variable load_balancer_name {
    default = ""
}

variable iam_role_arn {
    default = ""
}

variable load_balancer {}

variable name {}
