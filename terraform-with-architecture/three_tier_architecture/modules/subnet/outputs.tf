# public subnet id를 output으로 내보내기    
output "public_subnet_ids" {
  value = [aws_subnet.public1.id, aws_subnet.public2.id]
}

# private subnet id를 output으로 내보내기
output "private_subnet_ids" {
  value = [aws_subnet.private1.id, aws_subnet.private2.id]
}
