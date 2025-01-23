variable "key_name" { # key_name을 변수로 선언
    description = "The name of the key pair to use for the EC2 instance"
}

variable "public_subnet_ids" { # public_subnet_ids를 변수로 선언
    description = "The IDs of the public subnets"
}

variable "private_subnet_ids" { # private_subnet_ids를 변수로 선언
    description = "The IDs of the private subnets"
}

variable "security_group_id" { # security_group_id를 변수로 선언
    description = "The ID of the security group"
}