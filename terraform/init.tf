provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_instance" "wb" {
  ami                         = "ami-0986c2ac728528ac2"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-05e77cd6231c44dfb"
  associate_public_ip_address = true
}
