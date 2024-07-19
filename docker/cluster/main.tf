resource "aws_ecs_cluster" "class3" {
  name = "class3"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}