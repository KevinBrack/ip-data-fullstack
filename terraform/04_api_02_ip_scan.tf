variable "zip_02_root" {
  default = "../api/02_ip_scan/ip_scan_payload.zip"
}

# LAMBDA FUNCTION
resource "aws_lambda_function" "ip_scan" {
  filename         = "${var.zip_02_root}"
  function_name    = "ip_scan"
  role             = "${aws_iam_role.ip_lambda_role.arn}"
  handler          = "exports.handler"
  source_code_hash = "${filebase64sha256("${var.zip_02_root}")}"
  runtime          = "nodejs10.x"
}

# FUNCTION PERMISSIONS
resource "aws_lambda_permission" "lambda_permission_02" {
  statement_id  = "AllowIpApiInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.ip_scan.function_name}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.IpApi.execution_arn}/*/*/*"
}
resource "aws_lambda_permission" "apigw_lambda_02" {
  statement_id  = "AllowExicutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.ip_scan.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.IpApi.id}/*/${aws_api_gateway_resource.ip_scan.path}"
}

# RESOURCE
resource "aws_api_gateway_resource" "ip_scan" {
  path_part   = "ip_scan"
  parent_id   = "${aws_api_gateway_rest_api.IpApi.root_resource_id}"
  rest_api_id = "${aws_api_gateway_rest_api.IpApi.id}"
}

# METHOD
resource "aws_api_gateway_method" "post_scan" {
  rest_api_id   = "${aws_api_gateway_rest_api.IpApi.id}"
  resource_id   = "${aws_api_gateway_resource.ip_scan.id}"
  http_method   = "POST"
  authorization = "NONE"
}

# INTEGRATION
resource "aws_api_gateway_integration" "int_ip_scan_post" {
  rest_api_id             = "${aws_api_gateway_rest_api.IpApi.id}"
  resource_id             = "${aws_api_gateway_resource.ip_scan.id}"
  http_method             = "${aws_api_gateway_method.post_scan.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.myregion}:lambda:path/2015-03-31/functions/${aws_lambda_function.ip_scan.arn}/invocations"
}
