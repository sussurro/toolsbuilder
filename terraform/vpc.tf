
resource "aws_security_group" "ghh_windows" {
  vpc_id      = aws_default_vpc.default.id
  name        = "ghh_windows"
  description = "security group that allows windows ports"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["224.0.0.0/24"]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = var.ip_allowlist
  }

  ingress {
    from_port   = 5985
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = var.ip_allowlist
  }

  tags = {
    Name = "ghh-rules"
  }
}

