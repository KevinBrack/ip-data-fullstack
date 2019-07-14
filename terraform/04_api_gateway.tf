# Variables
# Refrenced [region, accountId] from secret.tfvars

# API Gateway
# REST API
resource "aws_api_gateway_rest_api" "ip_api" {
  name = "ip_api"
}

# RESOURCE
resource "aws_api_gateway_resource" "resource" {
  path_part   = "resource"
  parent_id   = "${aws_api_gateway_rest_api.ip_api.root_resource_id}"
  rest_api_id = "${aws_api_gateway_rest_api.ip_api.id}"
}

# METHOD
resource "aws_api_gateway_method" "method" {
  rest_api_id   = "${aws_api_gateway_rest_api.ip_api.id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method   = "GET"
  authorization = "NONE"
}

# INTEGRATION 
resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.ip_api.id}"
  resource_id             = "${aws_api_gateway_resource.resource.id}"
  http_method             = "${aws_api_gateway_method.method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.myregion}:lambda:path/2015-03-31/functions/${aws_lambda_function.ip_hello_world.arn}/invocations"
}

# Lambda
# LAMBDA PERMISSION
# Allows exectution from API gateway
# source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
# ^^^ EXAMPLE

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.ip_hello_world.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.ip_api.id}:${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
  # ^^^ This line failing currently
}

# LOAD BALANCER
resource "aws_lb" "ip_lb" {
  name               = "${var.lb_name}"
  internal           = true
  load_balancer_type = "network"
  subnets            = ["${var.pub_subnet_id}"]
}

# resource "aws_api_gateway_vpc_link"
resource "aws_api_gateway_vpc_link" "ip_api_link" {
  name        = "${var.vpc_link_name}"
  target_arns = ["${aws_lb.ip_lb.arn}"]
}
