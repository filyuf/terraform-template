resource "aws_db_subnet_group" "your_db_subnet_group" {
  name       = "your_db_subnet_group_name"
  subnet_ids = [
    aws_subnet.your_private_subnet_1a.id,
    aws_subnet.your_private_subnet_1b.id
  ]

  tags = {
    Name = "your_db_subnet_group_name"
  }
}

resource "aws_db_instance" "your_db_instance" {
  identifier              = "your_db_identifier"
  allocated_storage       = 20
  db_name                 = "your_db_name"
  engine                  = "mariadb"
  engine_version          = "11.4.5"
  instance_class          = "db.t3.micro"
  username                = "your_db_username"
  password                = "your_db_password"
  publicly_accessible     = false
  multi_az                = false
  vpc_security_group_ids  = [aws_security_group.your_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.your_db_subnet_group.name
}
