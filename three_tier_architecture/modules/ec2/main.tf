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

# nat instance 생성
resource "aws_instance" "nat_instance"{
    ami = "ami-01c05ba56d996a2cf"
    instance_type = "t2.micro"
    subnet_id = var.public_subnet_ids[1]
    vpc_security_group_ids = [var.security_group_id]
    availability_zone = "ap-northeast-2c"
    key_name = var.key_name

    # nat instance는 source/destination check를 비활성화해야 함
    source_dest_check = false

    tags = {
        Name = "nat_instance"
    }
}

# web1 instance 생성
resource "aws_instance" "web1" {
    ami = "ami-040c33c6a51fd5d96"
    instance_type = "t2.micro"
    subnet_id = var.private_subnet_ids[0]
    vpc_security_group_ids = [var.security_group_id]
    availability_zone = "ap-northeast-2a"
    key_name = var.key_name

    tags = {
        Name = "web1"
    }
}

# web2 instance 생성
resource "aws_instance" "web2" {
    ami = "ami-040c33c6a51fd5d96"
    instance_type = "t2.micro"
    subnet_id = var.private_subnet_ids[1]
    vpc_security_group_ids = [var.security_group_id]
    availability_zone = "ap-northeast-2c"
    key_name = var.key_name

    tags = {
        Name = "web2"
    }
}