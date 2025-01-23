# main.tf란
# Terraform의 설정 파일로, Terraform이 실행될 때 가장 먼저 읽는 파일.

# aws provider 설정
provider "aws" {
    region = "ap-northeast-2"
}

# VPC 모듈 생성
module "vpc" {
    source = "./modules/vpc" # VPC 모듈의 경로
    
}

# subnet 모듈 생성
module "subnet"{
    source = "./modules/subnet" # subnet 모듈의 경로
    vpc_id = module.vpc.vpc_id # VPC 모듈에서 생성된 vpc_id를 subnet 모듈에 전달
    route_table_id = module.vpc.route_table_id # VPC 모듈에서 생성된 route_table_id를 subnet 모듈에 전달
}

# security_group 모듈 생성
module "security_group" {
    source = "./modules/security_group" # security_group 모듈의 경로
    vpc_id = module.vpc.vpc_id # VPC 모듈에서 생성된 vpc_id를 security_group 모듈에 전달
}

# key_pair 모듈 생성
module "key_pair" {
    source = "./modules/key_pair" # key_pair 모듈의 경로
}


# ec2 모듈 생성
module "ec2" {
    source = "./modules/ec2" # ec2 모듈의 경로
    public_subnet_ids = module.subnet.public_subnet_ids # subnet 모듈에서 생성된 public_subnet_ids를 ec2 모듈에 전달
    private_subnet_ids = module.subnet.private_subnet_ids # subnet 모듈에서 생성된 private_subnet_ids를 ec2 모듈에 전달
    security_group_id = module.security_group.security_group_id # subnet 모듈에서 생성된 security_group_id를 ec2 모듈에 전달
    key_name = module.key_pair.key_name # subnet 모듈에서 생성된 key_name을 ec2 모듈에 전달
}