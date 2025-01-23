# keypair 생성 후 private key를 local file로 저장
resource "tls_private_key" "example" {
    algorithm = "RSA"
    rsa_bits = 2048
}

resource "aws_key_pair" "my_key" {
    key_name = "my_key"
    public_key = tls_private_key.example.public_key_openssh
}

# private key를 local file로 저장
resource "local_file" "private_key" {
    content = tls_private_key.example.private_key_pem
    filename = "${path.module}/my_key.pem"  # 수정된 경로
}