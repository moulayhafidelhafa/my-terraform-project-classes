resource "aws_ecs_task_definition" "application" {
  family                = "application"
  execution_role_arn    = "arn:aws:iam::767397838496:role/ecsTaskExecutionRole"
  task_role_arn         = "arn:aws:iam::767397838496:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([
    {
      "name": "wordpress",
      "image": "docker.io/wordpress:latest",
      "cpu": 0,
      "portMappings": [
        {
          "name": "wordpress-80-tcp",
          "containerPort": 80,
          "hostPort": 80,
          "protocol": "tcp",
          "appProtocol": "http"
        }
      ],
      "essential": true,
      "environment": [],
      "environmentFiles": [],
      "mountPoints": [],
      "volumesFrom": [],
      "ulimits": [],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/application",
          "awslogs-create-group": "true",
          "awslogs-region": var.region,  # Reference the 'region' variable
          "awslogs-stream-prefix": "ecs"
        },
        "secretOptions": []
      },
      "systemControls": []
    }
  ])
}











