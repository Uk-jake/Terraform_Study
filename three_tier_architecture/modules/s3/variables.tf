# bucket name 변수
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

# bucket acl 변수
variable "bucket_acl" {
  description = "The ACL for the S3 bucket"
  type        = string
}