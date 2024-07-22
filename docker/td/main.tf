resource "aws_ecs_task_definition" "application" {
  family = "application"
  
  container_definitions = jsonencode([
    {
      name      = "wordpress"
      image     = "docker.io/wordpress:latest"
      cpu       = 0
      memory    = 512  # Specify the memory (in MiB) that your container needs
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/application"
          awslogs-region        = "us-east-2"
          awslogs-stream-prefix = "ecs"
          awslogs-create-group  = "true"
        }
      }
    }
  ]

  task_role_arn = "arn:aws:iam::767397838496:role/ecsTaskExecutionRole"
  execution_role_arn = "arn:aws:iam::767397838496:role/ecsTaskExecutionRole"
}












