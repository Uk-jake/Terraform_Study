# VPC 모듈의 main.tf
# VPC를 생성하는 리소스를 정의.
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"#var.vpc_cidr_block # VPC의 CIDR 블록
  # enable_dns_support = true
  # enable_dns_hostnames = true
  
  tags = {
    Name = "main-vpc" #var.vpc_name # VPC의 이름
  }
}

# VPC의 인터넷 게이트웨이 생성
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id # VPC의 ID
  
  tags = {
    Name = "my-igw" #var.igw_name # 인터넷 게이트웨이의 이름
  }
}

# VPC의 라우팅 테이블 생성
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id # VPC의 ID
  
  route {
    cidr_block = "0.0.0.0/0" # 모든 IP 주소로의 라우팅
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "my-route-table" # 라우팅 테이블의 이름
  }
}

# 라우트 테이블 생성 - NAT instance
resource "aws_route_table" "main1"{
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-route-table-nat"
  }
}


resource "aws_route" "main" {

  route_table_id = aws_route_table.main1.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id = var.nat_instance_network_interface_id

}