resource "aws_default_subnet" "default_az1" {
  availability_zone = "${var.region}a"
  tags = {
    Name = "Default subnet for ${var.region}a"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "${var.region}b"
  tags = {
    Name = "Default subnet for ${var.region}b"
  }
}