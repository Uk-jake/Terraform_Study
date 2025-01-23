# bastionhost 생성
resource "aws_instance" "ec2" {
    ami = "ami-040c33c6a51fd5d96"
    instance_type = "t2.micro"
    subnet_id = var.public_subnet_ids[0]
    vpc_security_group_ids = [var.security_group_id]
    availability_zone = "ap-northeast-2a"
    key_name = var.key_name

    tags = {
        Name = "bastion_host"
    }   
}