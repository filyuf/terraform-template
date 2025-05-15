resource "aws_security_group" "sg_lb" {
  name   = "sg-lb"
  vpc_id = aws_vpc.your_vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    ipv6_cidr_blocks  = ["::/0"]
  }

  tags = {
    Name = "sg-lb"
  }
}

resource "aws_security_group" "sg_app" {
  name   = "sg-app"
  vpc_id = aws_vpc.your_vpc.id

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Port 2000"
    from_port   = 2000
    to_port     = 2000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "MariaDB Access from Load Balancer SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_lb.id]
  }

  ingress {
    description = "App Port 10000"
    from_port   = 10000
    to_port     = 10000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    ipv6_cidr_blocks  = ["::/0"]
  }

  tags = {
    Name = "sg-app"
  }
}
