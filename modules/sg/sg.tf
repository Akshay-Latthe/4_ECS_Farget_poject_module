
## ==== VPC's Default Security Group ======
resource "aws_security_group" "default-vpc" {
  name        = "akshay-vpc-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = var.vpc_id
  depends_on  = [var.vpc_id]
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }
  tags = {
    Name = "VPC-SG-01"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# SECURITY GROUP FOR ALB
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [80, 443]
    iterator = port
    content {
      description      = "TLS from VPC"
      from_port        = port.value
      to_port          = port.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
   tags = {
    Name = "ALB-SG"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# SECURITY GROUP FOR ECS TASKS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "WP-SG" {
  name        = "WP-SG"
  description = "Allow inbound access to ECS tasks from the ALB only"
  vpc_id      = var.vpc_id
  ingress {
    description     = "HTTPS"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb-sg.id}"]
  }
  ingress {
    description     = "HTTP for webserver"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "WP-SG-sg"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# SECURITY GROUP FOR EFS-sg
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "efs-sg" {
  name   = "ingress-efs-sg"
  vpc_id = var.vpc_id


  // NFS
  ingress {
    security_groups = ["${aws_security_group.WP-SG.id}"]
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
  }

  egress {
    security_groups = ["${aws_security_group.WP-SG.id}"]
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
  }
  tags = {
    Name = "MyEFS-SG"

  }
}

# ---------------------------------------------------------------------------------------------------------------------
# SECURITY GROUP FOR RDS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "db-sg" {
  name        = "${var.stack}-db-sg"
  description = "Access to the RDS instances from the VPC"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.stack}-db-sg"
  }
}

## =============================  redis_sg  

resource "aws_security_group" "redis_sg" {
  name        = "redis_sg"
  description = "Opening redis port for wordpress autoscaling group security group"
  vpc_id      = var.vpc_id
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb-sg.id}", "${aws_security_group.WP-SG.id}"]
  }
  ingress {
    description     = "SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp" # Here adding tcp instead of ssh, because ssh in part of tcp only!
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "redis_sg"
  }
}

# ## ===============================Bastion Host  ============================================================
# # Creating security group for Bastion Host/Jump Box  
# resource "aws_security_group" "BH-SG" {

#   depends_on  = [aws_vpc.vpc]
#   description = "MySQL Access only from the Webserver Instances!"
#   name        = "bastion-host-sg"
#   vpc_id      = aws_vpc.vpc.id

#   # Created an inbound rule for Bastion Host SSH
#   ingress {
#     description = "Bastion Host SG"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "output from Bastion Host"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }