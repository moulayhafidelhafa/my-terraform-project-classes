resource "aws_ecs_cluster"classtest" {
  name = "classtest"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}