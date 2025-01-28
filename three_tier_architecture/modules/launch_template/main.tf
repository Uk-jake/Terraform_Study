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
  name          = "web1-launch-template"
  image_id      = aws_ami_from_instance.web1_ami.id
  instance_type = var.instance_type
  key_name      = var.key_name

  security_group_names = [var.security_group_id]

  # user data 설정
  # user data는 EC2 인스턴스가 시작될 때 실행할 스크립트를 정의한다.
  # base64encode 함수를 사용하여 스크립트를 base64로 인코딩한다.
  # base64를 사용하는 이유는 user data에는 특수문자가 포함될 수 있기 때문이다.
  # base64로 인코딩하면 특수문자가 포함되어도 문제없이 실행된다.
  # 특수문자가 들어가면 스크립트가 정상적으로 실행되지 않을 수 있다.
  user_data = base64encode(<<-EOF
              #!/bin/bash

              # Java 설치
              sudo apt update
              sudo apt install -y openjdk-17-jdk

              # Java 설치 확인
              java -version

              # 기존 디렉토리 삭제
              rm -rf my-app-terraform

              # Git 저장소 클론
              git clone https://github.com/Nanninggu/my-app-terraform.git
              cd my-app-terraform

              # Gradle wrapper에 실행 권한 부여
              chmod +x gradlew

              # Gradle 빌드
              ./gradlew build

              # 빌드된 JAR 파일 실행
              java -jar build/libs/demo-0.0.1-SNAPSHOT.jar && echo "JAR file executed successfully"

              EOF
  )


  lifecycle {
    create_before_destroy = true
  }
}