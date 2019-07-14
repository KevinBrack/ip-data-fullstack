# FILE VARIABLE
variable "zip_01_root" {
  default = "../api/01_root/ip_root_payload.zip"
}

# LAMBDA FUNCTION
resource "aws_lambda_function" "root" {
  filename         = "${var.zip_01_root}"
  function_name    = "ip_root"
  role             = "${aws_iam_role.ip_lambda_role.arn}"
  handler          = "exports.handler"
  source_code_hash = "${filebase64sha256("${var.zip_01_root}")}"
  runtime          = "nodejs10.x"
}

# FUNCTION PERMISSIONS
resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowIpApiInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.root.function_name}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.IpApi.execution_arn}/*/*/*"
}
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExicutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.root.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.IpApi.id}/*/${aws_api_gateway_resource.root.path}"
}

# RESOURCE
resource "aws_api_gateway_resource" "root" {
  path_part   = "root"
  parent_id   = "${aws_api_gateway_rest_api.IpApi.root_resource_id}"
  rest_api_id = "${aws_api_gateway_rest_api.IpApi.id}"
}

# METHOD
resource "aws_api_gateway_method" "get_root" {
  rest_api_id   = "${aws_api_gateway_rest_api.IpApi.id}"
  resource_id   = "${aws_api_gateway_resource.root.id}"
  http_method   = "GET"
  authorization = "NONE"
}

# INTEGRATION
resource "aws_api_gateway_integration" "int_root_post" {
  rest_api_id             = "${aws_api_gateway_rest_api.IpApi.id}"
  resource_id             = "${aws_api_gateway_resource.root.id}"
  http_method             = "${aws_api_gateway_method.get_root.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.myregion}:lambda:path/2015-03-31/functions/${aws_lambda_function.root.arn}/invocations"
}
