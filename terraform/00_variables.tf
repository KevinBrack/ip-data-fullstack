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
  default = "subnet-07152c59d82f4670f"
}

variable "pub_subnet_id" {
  default = "subnet-05e77cd6231c44dfb"
}
