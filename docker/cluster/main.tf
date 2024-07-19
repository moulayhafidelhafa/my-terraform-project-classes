resource "aws_ecs_cluster"Devclass" {
  name = "Devclass"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}