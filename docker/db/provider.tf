provider "aws" {
  region = var.region
}




variable "region" {
  default = "us-east-2"
}