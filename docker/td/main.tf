resource "aws_ecs_task_definition" "application" {
  family                = "application"
  "executionRoleArn":   = "arn:aws:iam::767397838496:role/ecsTaskExecutionRole"
  "task_role_arn":      = "arn:aws:iam::767397838496:role/ecsTaskExecutionRole"
   containerDefinitions : <<TASK_DEFINITION
{    
    containerDefinitions" : [
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
       
    "family": "application",
    "networkMode": "awsvpc",
    "revision": 6,
    "volumes": [],
    "status": "ACTIVE",
    "requiresAttributes": [
        {
            "name": "com.amazonaws.ecs.capability.logging-driver.awslogs"
        },
        {
            "name": "ecs.capability.execution-role-awslogs"
        },
        {
            "name": "com.amazonaws.ecs.capability.docker-remote-api.1.19"
        },
        {
            "name": "com.amazonaws.ecs.capability.docker-remote-api.1.18"
        },
        {
            "name": "ecs.capability.task-eni"
        },
        {
            "name": "com.amazonaws.ecs.capability.docker-remote-api.1.29"
        }
    ],
    "placementConstraints": [],
    "compatibilities": [
        "EC2",
        "FARGATE"
    ],
    "requiresCompatibilities": [
        "FARGATE"
    ],
    "cpu": "1024",
    "memory": "3072",
    "runtimePlatform": {
        "cpuArchitecture": "X86_64",
        "operatingSystemFamily": "LINUX"
    },
    "registeredAt": "2024-07-20T15:21:37.057Z",
    "registeredBy": "arn:aws:iam::767397838496:root",
    "tags": []
}