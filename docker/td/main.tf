resource "aws_ecs_task_definition" "application" {
  family                = "application"
  execution_role_arn    = "arn:aws:iam::767397838496:role/ecsTaskExecutionRole"
  task_role_arn         = "arn:aws:iam::767397838496:role/ecsTaskExecutionRole"
  container_definitions = <<TASK_DEFINITION
  cpu                   = "1024"
  memory                = "3072"
[
}
    "containerDefinitions": [
        {
            "name": "wordppress",
            "image": "docker.io/wordpress:latest",
            "cpu": 0,
            "portMappings": [
                {
                    "name": "wordppress-80-tcp",
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
                    "awslogs-region": "us-east-2",
                    "awslogs-stream-prefix": "ecs"
                },
                "secretOptions": []
            },
            "systemControls": []
        }
]
TASK_DEFINITION
}








