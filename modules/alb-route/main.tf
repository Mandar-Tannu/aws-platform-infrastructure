#########################################################
# Target Group
#########################################################

resource "aws_lb_target_group" "this" {

  name = var.target_group_name

  port = var.port

  protocol = var.protocol

  target_type = var.target_type

  vpc_id = var.vpc_id

  health_check {

    enabled = true

    protocol = var.protocol

    path = var.health_check_path

    port = "traffic-port"

    matcher = "200"

    interval = 30

    timeout = 5

    healthy_threshold = 2

    unhealthy_threshold = 2

  }

  tags = merge(
    var.common_tags,
    {
      Name = var.target_group_name
    }
  )
}

#########################################################
# Target Group Attachment
#########################################################

resource "aws_lb_target_group_attachment" "this" {

  target_group_arn = aws_lb_target_group.this.arn

  target_id = var.target_id

  port = var.port

}

#########################################################
# Listener Rule
#########################################################

resource "aws_lb_listener_rule" "this" {

  listener_arn = var.listener_arn

  priority = var.priority

  action {

    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn

  }

  condition {

    path_pattern {

      values = var.path_patterns

    }

  }

}

