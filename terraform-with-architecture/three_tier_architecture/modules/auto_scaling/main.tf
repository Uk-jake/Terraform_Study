# auto scaling resource 생성
resource "aws_autoscaling_group" "web1_asg" {

  name             = "web1-asg"
  max_size         = 3
  min_size         = 1
  desired_capacity = 1

  launch_template {
    id      = var.web1_launch_template_id
    version = "$Latest"
  }

  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = [var.aws_lb_target_group]

  tag {
    key                 = "Name"
    value               = "web1-asg"
    propagate_at_launch = true
  }
}

# auto scaling policy 생성
# 2개씩 증가/감소하도록 설정
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = 2                  # 2개씩 증가
  adjustment_type        = "ChangeInCapacity" # 증가
  cooldown               = 300                # 5분 동안은 추가 증가/감소 불가
  autoscaling_group_name = aws_autoscaling_group.web1_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = -2                 # 1개씩 감소
  adjustment_type        = "ChangeInCapacity" # 감소
  cooldown               = 300                # 5분 동안은 추가 증가/감소 불가
  autoscaling_group_name = aws_autoscaling_group.web1_asg.name
}

# CloudWatch metric 설정
# metric을 설정해서 trigger 설정
# CPUUtilization이 10% 이상이면 trigger
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high_cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold" # 비교 연산자 설정 - threshold와 비교할 연산자
  evaluation_periods  = 2                               # 2번 연속으로 threshold를 넘어야 trigger
  metric_name         = "CPUUtilization"                # metric 설정
  namespace           = "AWS/EC2"                       # metric이 EC2에 대한 metric
  period              = 120                             # 2분마다 metric을 확인
  statistic           = "Average"                       # 평균값을 기준으로 threshold를 설정
  threshold           = 10                              # 10% 이상이면 trigger
  alarm_description   = "This metric monitors ec2 instance CPU utilization"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web1_asg.name
  }
}

# CPUUtilization이 5% 이하이면 trigger
resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "low_cpu"
  comparison_operator = "LessThanOrEqualToThreshold" # 비교 연산자 설정 - threshold와 비교할 연산자
  evaluation_periods  = 2                            # 2번 연속으로 threshold를 넘어야 trigger
  metric_name         = "CPUUtilization"             # metric 설정
  namespace           = "AWS/EC2"                    # metric이 EC2에 대한 metric
  period              = 120                          # 2분마다 metric을 확인
  statistic           = "Average"                    # 평균값을 기준으로 threshold를 설정
  threshold           = 5                            # 5% 이하이면 trigger
  alarm_description   = "This metric monitors ec2 instance CPU utilization"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web1_asg.name
  }
}