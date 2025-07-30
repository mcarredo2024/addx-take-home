resource "aws_db_subnet_group" "db_subnet" {
  name       = "rds-subnet-group"
  subnet_ids = concat(var.private_subnets, var.public_subnets)
  tags = {
    Name = "rds-subnet-group"
  }
}


resource "aws_security_group" "db" {
  name   = "rds-db-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Postgres from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "Postgres from Marvin Home"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["39.109.170.239/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "postgres" {
  identifier             = "nodejs-postgres"
  engine                 = "postgres"
  engine_version         = "15.7"
  instance_class         = "db.t4g.micro"
  allocated_storage      = 20
  db_name                = "addx"
  username               = var.db_user
  password               = var.db_password
  skip_final_snapshot    = false
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible    = true
  apply_immediately      = true
}

