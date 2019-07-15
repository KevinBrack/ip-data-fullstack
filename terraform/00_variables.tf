variable "myregion" {
  default = "us-east-2"
}

# not sure if safe to have in source so placed in "../private/secret.tfvars"
# include -var-file="../private/secret.tfvars" with `terraform plan` and `terraform apply`
variable "accountId" {}

variable "virusTotalKey" {}
