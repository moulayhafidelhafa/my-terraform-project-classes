resource "aws_ecs_cluster" "class4" {
  name = "class4"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}