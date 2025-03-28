# Auto Scaling Group
resource "aws_autoscaling_group" "app_asg" {
    desired_capacity = 2
    max_size = 4
    min_size = 2
    
    # Explicitly specify subnets
    vpc_zone_identifier = [
        aws_subnet.subnet_1.id,
        aws_subnet.subnet_2.id
    ]

    launch_template {
      id = aws_launch_template.app.id
      version = "$Latest"
    }

    target_group_arns = [ aws_lb_target_group.app_tg.arn ]

    health_check_type         = "ELB"
    health_check_grace_period = 300

    tag {
      key = "Name"
      value = "Appp-Instance"
      propagate_at_launch = true
    }

    lifecycle {
      create_before_destroy = true
    }
}

# Auto Scaling Policies
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
}
