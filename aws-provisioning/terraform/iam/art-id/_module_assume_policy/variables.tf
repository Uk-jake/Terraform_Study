/*
 * Required
 */

variable "aws_account" {
  description = "aws account name (ex. iot-id, iot-preprod)"
}

variable "subject" {
  description = ""
}

variable "resources" {
  type        = list
  description = "List of affected resources."
  default     = ["*"]
}
