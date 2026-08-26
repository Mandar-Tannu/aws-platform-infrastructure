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

    type = "redirect"

    redirect {

      port = "443"

      protocol = "HTTPS"

      status_code = "HTTP_301"

    }

  }

}

#########################################################
# HTTPS Listener
#########################################################

resource "aws_lb_listener" "https" {

  load_balancer_arn = aws_lb.this.arn

  port = 443

  protocol = "HTTPS"

  ssl_policy = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"

  certificate_arn = var.certificate_arn

  default_action {

    type = "fixed-response"

    fixed_response {

      content_type = "text/plain"

      message_body = "Not Found"

      status_code = "404"

    }

  }

}

