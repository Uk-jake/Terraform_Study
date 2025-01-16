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