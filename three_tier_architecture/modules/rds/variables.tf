# DB 이름
variable "db_name" {
  description = "The name of the database to create"
  type       = string
}

# DB 사용자 이름
variable "username" {
  description = "The username for the database"
  type       = string
}

# DB 비밀번호
variable "password" {
  description = "The password for the database"
  type       = string
  sensitive  = true

}

# 인스턴스 클래스
variable "instance_class" {
    description = "The instance class to use"
    type        = string
    default     = "db.t3.micro"
}

# 스토리지 크기
variable "allocated_storage" {
    description = "The amount of storage to allocate"
    type        = number
    default     = 20
}

# 보안 그룹 ID
variable "vpc_security_group_ids" {
  description = "A list of VPC security group IDs to associate with the RDS instance"
  type        = list(string)
}

# 서브넷 ID
variable "subnet_ids" {
  description = "A list of VPC subnet IDs to associate with the RDS instance"
  type        = list(string)
}