# # Variables
# # Refrenced [region, accountId] from secret.tfvars

# # API Gateway
# # REST API
# resource "aws_api_gateway_rest_api" "ip_api" {
#   name = "ip_api"
# }

# # LOAD BALANCER
# resource "aws_lb" "ip_lb" {
#   name               = "${var.lb_name}"
#   internal           = true
#   load_balancer_type = "network"
#   subnets            = ["${var.pub_subnet_id[1]}"]
# }

# # resource "aws_api_gateway_vpc_link"
# resource "aws_api_gateway_vpc_link" "ip_api_link" {
#   name        = "${var.vpc_link_name}"
#   target_arns = ["${aws_lb.ip_lb.arn}"]
# }
