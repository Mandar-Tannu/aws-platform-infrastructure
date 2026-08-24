#########################################################
# ALB Outputs
#########################################################

output "load_balancer_arn" {

  description = "Application Load Balancer ARN"

  value = aws_lb.this.arn

}

output "load_balancer_dns_name" {

  description = "ALB DNS Name"

  value = aws_lb.this.dns_name

}

output "load_balancer_zone_id" {

  description = "Hosted Zone ID"

  value = aws_lb.this.zone_id

}

output "http_listener_arn" {

  description = "HTTP Listener ARN"

  value = aws_lb_listener.http.arn

}

