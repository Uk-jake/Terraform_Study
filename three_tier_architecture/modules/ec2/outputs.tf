# nat_instance_network_interface_id
output "nat_instance_network_interface_id" {
  value = aws_instance.nat_instance.primary_network_interface_id
}

# web1 instance id
output "web1_instance_id" {
  value = aws_instance.web1.id
}

# web2 instance id
output "web2_instance_id" {
  value = aws_instance.web2.id
}