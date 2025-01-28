variable "vpc_id" {
  description = "The VPC ID where the ALB will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs where the ALB will be deployed"
  type        = list(string)
}

variable "security_group_id" {
  description = "The security group ID for the ALB"
  type        = list(string)
}

variable "target_instance_ids" {
  description = "The target instance IDs for the ALB"
  type        = list(string)
}