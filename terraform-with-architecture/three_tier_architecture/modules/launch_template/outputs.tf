output "web1_launch_template_id" {
  description = "The ID of the launch template for the web1 instance"
  value       = aws_launch_template.web1_launch_template.id
}