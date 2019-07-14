variable "myregion" {
  default = "us-east-2"
}

# not sure if safe to have in source so placed in "../private/secret.tfvars"
# include -var-file="../private/secret.tfvars" with `terraform plan` and `terraform apply`
variable "accountId" {}

variable "lb_name" {
  default = "ip-api-lb"
}
variable "vpc_link_name" {
  default = "ip-api-vpc-link"
}

variable "priv_subnet_id" {
  type = "map"
  default = {
    "1" = "subnet-07152c59d82f4670f"
    "2" = "subnet-09e1644d12384fe02"
  }
}

variable "pub_subnet_id" {
  type = "map"
  default = {
    "1" = "subnet-05e77cd6231c44dfb"
    "2" = "subnet-00f25ec3f84a3b44c"
  }
}

variable "ubuntu_ami" {
  default = "ami-0986c2ac728528ac2" 
}
