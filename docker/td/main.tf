# Define the VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

# Define the subnets
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet2"
  }
}

# Define the ECS task definition
resource "aws_ecs_task_definition" "application" {
  family                = "application"
  execution_role_arn    = "arn:aws:iam::767397838496:role/ecsTaskExecutionRole"
  task_role_arn         = "arn:aws:iam::767397838496:role/ecsTaskExecutionRole"
  requires_compatibilities = ["FARGATE"]
  network_mode          = "awsvpc"
  cpu                   = "256"
  memory                = "512"
  container_definitions = <<DEFINITION
[
  {
    "name": "wordpress",
    "image": "docker.io/wordpress:latest",
    "cpu": 0,
    "memory": 512,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ],
    "essential": true,
    "environment": [],
    "mountPoints": [],
    "volumesFrom": [],
    "ulimits": [],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/application",
        "awslogs-create-group": "true",
        "awslogs-region": "us-east-2",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "systemControls": []
  }
]
DEFINITION
}

# Optional: Security group to allow traffic to the ECS tasks
resource "aws_security_group" "ecs_security_group" {
  name        = "ecs_security_group"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

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

  tags = {
    Name = "ecs_security_group"
  }
}

