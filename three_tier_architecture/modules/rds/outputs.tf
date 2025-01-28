# DB instance ID
output "db_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.this.id
}

# DB endpoint address
output "db_instance_endpoint" {
  description = "The endpoint address of the RDS instance"
  value       = aws_db_instance.this.endpoint
}