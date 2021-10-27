data "aws_availability_zones" "this" {
  state = "available"
}

data "aws_ami" "tools_image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["server2019-toolsbuild-*"]
  }


  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self"] 
}
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "default_subnet" {
  availability_zone = "us-east-2a"

  tags = {
    Name = "Default subnet for us-west-2a"
  }
}

