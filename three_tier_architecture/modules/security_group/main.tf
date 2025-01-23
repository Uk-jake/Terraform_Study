resource "aws_security_group" "allow_ssh" {

    name = "allow_ssh"
    description = "Allow SSH inbound traffic"
    vpc_id = var.vpc_id

    # 들어오는 트래픽을 허용
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # 들어오는 모든 트래픽 허용
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }

    # 나가는 트래픽을 허용
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1" # 모든 프로토콜을 허용
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow_ssh"
    }

}