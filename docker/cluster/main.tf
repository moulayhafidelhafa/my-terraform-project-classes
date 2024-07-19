resource "aws_ecs_cluster"devclass" {
  name = "devclass"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}