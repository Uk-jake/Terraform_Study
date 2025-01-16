# 1. AWS provider 설정
provider "aws"{
    region = "ap-northeast-2"
}

# 2. VPC 생성
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "my-vpc"
    }
}

# 3. 인터넷 게이트웨이 생성
resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "my-igw"
    }
}


# 4. 라우팅 테이블 생성
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.vpc.id

    route{
        cidr_block="0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "my-route-table"
    }
}

# 5. Public 서브넷 생성 1
resource "aws_subnet" "public_subnet"{
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
      availability_zone = "ap-northeast-2a"

        tags = {
            Name = "my-public-subnet-1"
        }
}

# 6. Public 서브넷 생성 2
# resource "aws_subnet" "public_subnet2"{
#     vpc_id = aws_vpc.vpc.id
#     cidr_block = "10.0.2.0/24"
#       availability_zone = "ap-northeast-2c"

#         tags = {
#             Name = "my-public-subnet-2"
#         }
# }

# 7. Public 서브넷과 라우팅 테이블 연결
resource "aws_route_table_association" "rta" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.rt.id
}

# 8. 보안 그룹 생성 (SSH)
resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.vpc.id

    # SSH
    # 인바운드
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    # 아웃바운드
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1" # 모든 프로토콜을 의미함.
        cidr_blocks = ["0.0.0.0/0"]
    }

    # 이름 설정
    tags = {
        Name = "my-vpc-sg"
    }
}

# 9. 개인키 생성
resource "tls_private_key" "my_key" {
    algorithm = "RSA"
    rsa_bits = 2048
}

# 10. 개인키를 활용한 키페어 생성
resource "aws_key_pair" "my_key" {
    key_name = "my_key" # 키페어 이름
    public_key = tls_private_key.my_key.public_key_openssh # 공개키
}

# 10. 로컬에 키페어 파일 생성
resource "local_file" "private_key" {
    content = tls_private_key.my_key.private_key_pem
    filename = "${path.module}/my_key.pem" # 현재 디렉토리에 키페어 저장
}

# 11. Public 서브넷에 EC2 인스턴스 생성
resource "aws_instance" "ec2" {
    ami = "ami-042e76978adeb8c48"
    instance_type = "t2.micro"
    key_name = aws_key_pair.my_key.key_name
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "my-ec2-instance-terraform"
    }
}

# 12. EC2 인스턴스에 Elastic IP 할당
# Elastic IP 란?
# EC2 인스턴스에 고정된 퍼블릭 IP 주소를 할당하는 서비스
resource "aws_eip" "eip" {
    instance = aws_instance.ec2.id
    vpc = true

    tags = {
        Name = "my-eip"
    }
}