# s3 모듈 생성
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  # s3 버킷 만들 때 기본적으로 private로 설정
  # acl    = var.bucket_acl
}
