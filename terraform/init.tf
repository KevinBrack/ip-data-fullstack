provider "aws" {
  profile = "ipchallenge"
  region  = "us-east-2"
}

resource "aws_instance" "test-ec2" {
  ami           = "ami-0606a0d9f566249d3"
  instance_type = "t2.micro"
}
