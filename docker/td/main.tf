resource "aws_ecs_task_definition" "application" {
  family                = "application"
  execution_role_arn    = "arn:aws:iam::767397838496:role/ecsTaskExecutionRole"
  task_role_arn         = "arn:aws:iam::767397838496:role/ecsTaskExecutionRole"
  cpu                   = "1824"
  memory                = "3072"
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

