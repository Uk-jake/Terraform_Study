variable "source_instance_id" {
  description = "The instance ID of the web1 instance"
  type        = string
}

variable "key_name" {
  description = "The key pair name to use for the launch template"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the launch template"
  type        = string
  default     = "t2.micro"
}
