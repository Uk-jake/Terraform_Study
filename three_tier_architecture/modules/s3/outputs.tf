# bucket arn 출력
output "bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}

# bucket name 출력
output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}