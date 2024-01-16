# ---------------------------------------------------------------------------------------------------------------------
# ALB
# ---------------------------------------------------------------------------------------------------------------------
# data "aws_route53_zone" "zone" {
#   name = "dev.devopsinabox.aaic.cc"  # Replace with your actual domain name
# }

resource "aws_lb" "wordpress-alb" {
  name               = "wordperss-lb-tf"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [var.alb-sg] #[aws_security_group.alb-sg.id]
  subnets            = var.public_subnets # local.public_subnet_ids ## 
  tags = {
    Environment = "production"
  }
}
# ---------------------------------------------------------------------------------------------------------------------
# ALB TARGET GROUP
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_lb_target_group" "my-target-group" {
  health_check {
    protocol            = "HTTP"
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 7
    interval            = 45
    matcher             = "200-499"
  }
  name        = "demo-tg-alb"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

}

# ---------------------------------------------------------------------------------------------------------------------
# ALB LISTENER FOR HTTP TERRAFIC {WODRKING}
# ---------------------------------------------------------------------------------------------------------------------

# resource "aws_lb_listener" "alb-htts-listner" {
#   load_balancer_arn = aws_lb.wordpress-alb.id
#   port              = 80
#   protocol          = "HTTP"
#   default_action {
#     type             = "forward" ## DEFAULT IS "forward" CHANGE TO "redirect"
#     target_group_arn = aws_lb_target_group.my-target-group.id
#   }
# }


# ---------------------------------------------------------------------------------------------------------------------
# ALB LISTENER  FOR HTTPS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_lb_listener" "alb-htts-listner" {
  load_balancer_arn = aws_lb.wordpress-alb.arn
  port              =  80
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        =  443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "alb_https_listener" {
  
  load_balancer_arn = aws_lb.wordpress-alb.arn
  port              =   443
  protocol          =  "HTTPS"
  ssl_policy        =  var.ssl_policy # Change to the appropriate SSL policy if needed
  certificate_arn   = aws_acm_certificate.ssl_certificate.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-target-group.arn
  }
}






