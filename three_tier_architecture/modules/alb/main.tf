# alb module 생성
resource "aws_lb" "this" {
    # alb 이름
    name               = "my-alb"
    # alb internal 여부
    internal           = false
    # alb 타입
    load_balancer_type = "application"
    # alb 보안 그룹 ID
    security_groups    = var.security_group_id
    # alb 서브넷 ID
    subnets            = var.subnet_ids
    # 삭제 보호 비활성화: true로 설정하면 리소스가 삭제되지 않음
    enable_deletion_protection = false
}

# target group 생성
resource "aws_lb_target_group" "this" {
    # target group 이름
    name     = "my-target-group"
    # target group 프로토콜
    protocol = "HTTP"
    # target group 포트
    port     = 8080
    # target group VPC ID
    vpc_id   = var.vpc_id

    # target group health check
    health_check {
        # target group health check 경로
        path                = "/"
        # target group health check 프로토콜
        protocol            = "HTTP"
        # target group health check 포트
        # port                = "traffic-port"
        # target group health check 시간
        timeout             = 5
        # target group health check 간격
        interval            = 30
        # target group health check 성공 횟수
        healthy_threshold   = 2
        # target group health check 실패 횟수
        unhealthy_threshold = 2
    }

    # stickiness {
    #    type = "lb_cookie"
    #    cookie_duration = 86400 # 1 day
    #     # target group stickiness 활성화 여부
    #     enabled = false
    # }
}

# alb 리스너 생성
resource "aws_lb_listener" "this" {
    # alb 리스너 포트
    port = "8080"
    # alb 리스너 프로토콜
    protocol = "HTTP"
    # alb 리스너 alb arn
    load_balancer_arn = aws_lb.this.arn

    # alb 리스너 default action
    default_action {
        # alb 리스너 default action 유형
        type             = "forward"
        # alb 리스너 default action target group arn
        target_group_arn = aws_lb_target_group.this.arn
    }
}

# target group attachment 생성
resource "aws_lb_target_group_attachment" "web1" {
    # target group attachment target group arn
    target_group_arn = aws_lb_target_group.this.arn
    # target group attachment target ID
    target_id        = var.target_instance_ids[0]
    port             = 8080
}

resource "aws_lb_target_group_attachment" "web2" {
    # target group attachment target group arn
    target_group_arn = aws_lb_target_group.this.arn
    # target group attachment target ID
    target_id        = var.target_instance_ids[1]
    port             = 8080
}