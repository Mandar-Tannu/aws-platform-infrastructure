#########################################################
# Application Load Balancer
#########################################################

resource "aws_lb" "this" {

  name = "${var.project_name}-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [
    var.security_group_id
  ]

  subnets = var.subnet_ids

  enable_deletion_protection = false

  idle_timeout = 60

  drop_invalid_header_fields = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-alb"
    }
  )
}

#########################################################
# HTTP Listener
#########################################################

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.this.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "fixed-response"

    fixed_response {

      content_type = "text/plain"

      message_body = "Application Load Balancer Ready"

      status_code = "200"

    }

  }

}

