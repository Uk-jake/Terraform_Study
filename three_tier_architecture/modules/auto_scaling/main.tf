# auto scaling resource 생성
resource "aws_autoscaling_group" "web1_asg" {
    
    name                 = "web1-asg"
    max_size             = 3
    min_size             = 1
    desired_capacity     = 1

    launch_template {
      id     = var.web1_launch_template_id
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