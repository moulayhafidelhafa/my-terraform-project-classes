resource "aws_default_subnet" "default_az1" {
  availability_zone = "${var.region}a"
  tags = {
    Name = "Default subnet for ${var.region}a"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "${var.region}b"
  tags = {
    Name = "Default subnet for ${var.region}b"
  }
}

resource "aws_default_subnet" "default_az3" {
  availability_zone = "${var.region}b"
  tags = {
    Name = "Default subnet for ${var.region}b"
  }
}


resource "aws_db_subnet_group" "default" {
  name = "ecs"
  subnet_ids = [
    aws_default_subnet.default_az1.id,
    aws_default_subnet.default_az2.id,
    aws_default_subnet.default_az3.id,
  ]
}


resource "aws_security_group" "ecsdb" {
  name        = "ecsdb"
  description = "Allow MySQL access"

  ingress {
    from_port   = 3306
    to_port     = 3306
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



resource "random_password" "user" {
  length  = 8
  special = false
  numeric  = false
  upper   = false
}

resource "random_password" "password" {
  length  = 16
  special = true
  numeric  = true
  upper   = false
}

resource "aws_db_instance" "default" {
  db_subnet_group_name   = aws_db_subnet_group.default.name
  allocated_storage      = 10
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = random_password.user.result
  password               = random_password.password.result
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.ecsdb.id]
}

resource "null_resource" "create_db" {
  provisioner "local-exec" {
    command = <<EOT
mysql -h ${aws_db_instance.default.address} -u${random_password.user.result} -p${random_password.password.result} -e "CREATE DATABASE wordpress;"
    EOT
  }

  depends_on = [aws_db_instance.default]
}


resource "aws_secretsmanager_secret" "ecs_db_credentials" {
  name = "ecs_db_credentials"
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.ecs_db_credentials.id
  secret_string = jsonencode({
    username = random_password.user.result
    password = random_password.password.result
    host     = aws_db_instance.default.address
    db_name  = "wordpress"
  })
}