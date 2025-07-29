module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name               = "nodejs-alb"
  load_balancer_type = "application"
  vpc_id             = var.vpc_id
  subnets            = var.public_subnets

  security_groups = [aws_security_group.alb.id]

  # Target group for Node.js app
  target_groups = [
    {
      name_prefix      = "nodejs-"
      backend_protocol = "HTTP"
      backend_port     = 30080  # NodePort in EKS
      target_type      = "instance"
      health_check = {
        path                = "/users"
        protocol            = "HTTP"
        matcher             = "200"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
      }
    }
  ]

  listeners = [
    {
      port     = 80
      protocol = "HTTP"
      default_action = {
        type             = "forward"
        target_group_arn = element(module.alb.target_group_arns, 0)
      }
    }
  ]
}

resource "aws_security_group" "alb" {
  name        = "alb-sg"
  description = "Allow HTTP access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Attach EKS nodes to Target Group
resource "aws_lb_target_group_attachment" "eks_nodes" {
  count            = length(var.eks_node_private_ips)
  target_group_arn = element(module.alb.target_group_arns, 0)
  target_id        = var.eks_node_private_ips[count.index]
  port             = 30080
}
