# ALB Security Group
resource "aws_security_group" "alb_sg" {

  name = "${var.project_name}-alb-sg"

  description = "Security Group for Application Load Balancer"

  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-alb-sg"
    }
  )
}

# Allow HTTP
resource "aws_vpc_security_group_ingress_rule" "alb_http" {

  security_group_id = aws_security_group.alb_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 80
  to_port   = 80

  ip_protocol = "tcp"

  description = "Allow HTTP"
}

# Allow HTTPS
resource "aws_vpc_security_group_ingress_rule" "alb_https" {

  security_group_id = aws_security_group.alb_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 443
  to_port   = 443

  ip_protocol = "tcp"

  description = "Allow HTTPS"
}

# Allow Outbound
resource "aws_vpc_security_group_egress_rule" "alb_outbound" {

  security_group_id = aws_security_group.alb_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "Allow All Outbound"
}

# Jenkins Security Group
resource "aws_security_group" "jenkins_sg" {

  name = "${var.project_name}-jenkins-sg"

  description = "Security Group for Jenkins"

  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-jenkins-sg"
    }
  )
}

# Jenkins Ingress
resource "aws_vpc_security_group_ingress_rule" "jenkins_ui" {

  security_group_id = aws_security_group.jenkins_sg.id

  referenced_security_group_id = aws_security_group.alb_sg.id

  from_port = 8080
  to_port   = 8080

  ip_protocol = "tcp"

  description = "Allow Jenkins UI from ALB"
}

# Jenkins Egress
resource "aws_vpc_security_group_egress_rule" "jenkins_outbound" {

  security_group_id = aws_security_group.jenkins_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "Allow Outbound Traffic"
}

# SonarQube Security Group
resource "aws_security_group" "sonarqube_sg" {

  name = "${var.project_name}-sonarqube-sg"

  description = "Security Group for SonarQube"

  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-sonarqube-sg"
    }
  )
}

# SonarQube Ingress
resource "aws_vpc_security_group_ingress_rule" "sonarqube_ui" {

  security_group_id = aws_security_group.sonarqube_sg.id

  referenced_security_group_id = aws_security_group.alb_sg.id

  from_port = 9000
  to_port   = 9000

  ip_protocol = "tcp"

  description = "Allow SonarQube UI from ALB"
}

# SonarQube Egress
resource "aws_vpc_security_group_egress_rule" "sonarqube_outbound" {

  security_group_id = aws_security_group.sonarqube_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "Allow Outbound Traffic"
}

# Worker Node Security Group
resource "aws_security_group" "eks_node_sg" {

  name = "${var.project_name}-eks-node-sg"

  description = "Security Group for Amazon EKS Worker Nodes"

  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-eks-node-sg"
    }
  )
}

# Worker Node Egress
resource "aws_vpc_security_group_egress_rule" "eks_node_outbound" {

  security_group_id = aws_security_group.eks_node_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "Allow Outbound Traffic"
}

# PostgreSQL Security Group
resource "aws_security_group" "rds_sg" {

  name = "${var.project_name}-rds-sg"

  description = "Security Group for Amazon RDS PostgreSQL"

  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-rds-sg"
    }
  )
}

# RDS PostgreSQL Ingress from EKS Worker Node
resource "aws_vpc_security_group_ingress_rule" "postgres_from_eks" {

  security_group_id = aws_security_group.rds_sg.id

  referenced_security_group_id = aws_security_group.eks_node_sg.id

  from_port = 5432
  to_port   = 5432

  ip_protocol = "tcp"

  description = "Allow PostgreSQL access from EKS Worker Nodes"
}

# RDS PostgreSQL Ingress from SonarQube EC2
resource "aws_vpc_security_group_ingress_rule" "postgres_from_sonarqube" {

  security_group_id = aws_security_group.rds_sg.id

  referenced_security_group_id = aws_security_group.sonarqube_sg.id

  from_port = 5432
  to_port   = 5432

  ip_protocol = "tcp"

  description = "Allow PostgreSQL access from SonarQube EC2"
}


# RDS PostgreSQL Egress
resource "aws_vpc_security_group_egress_rule" "rds_outbound" {

  security_group_id = aws_security_group.rds_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "Allow Outbound Traffic"
}




