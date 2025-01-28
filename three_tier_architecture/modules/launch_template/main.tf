# aws launch template 생성
# launch template은 EC2 인스턴스를 생성할 때 필요한 정보를 미리 정의해놓은 템플릿이다.
# auto scaling group에서 EC2 인스턴스를 생성할 때 이 launch template을 참조한다.

# aws ami 생성
resource "aws_ami_from_instance" "web1_ami" {
    name               = "web1-ami"
    source_instance_id = var.source_instance_id
    # lifecycle 이란
    # create_before_destroy = true 옵션을 주면, 리소스를 업데이트할 때 새로운 리소스를 생성하고 기존 리소스를 삭제한다.
    lifecycle {
        create_before_destroy = true
    }
}

# aws launch template 생성
resource "aws_launch_template" "web1_launch_template" {
    name = "web1-launch-template"
    image_id = aws_ami_from_instance.web1_ami.id
    instance_type = var.instance_type
    key_name = var.key_name
    lifecycle {
        create_before_destroy = true
    }
}