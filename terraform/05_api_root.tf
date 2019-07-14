# # FUNCTION
# resource "aws_lambda_function" "ip_root" {
#   filename      = "../api/01_root/ip_root_payload.zip"
#   function_name = "ip_root"
#   role          = "${aws_iam_role.iam_for_ip_lambda.arn}"
#   handler       = "exports.handler"
#   runtime       = "nodejs10.x"

#   source_code_hash = "${filebase64sha256("../api/01_root/ip_root_payload.zip")}"
# }

# # RESOURCE
# resource "aws_api_gateway_resource" "root" {
#   path_part   = "root"
#   parent_id   = "${aws_api_gateway_rest_api.ip_api.root_resource_id}"
#   rest_api_id = "${aws_api_gateway_rest_api.ip_api.id}"
# }

# # METHOD
# resource "aws_api_gateway_method" "method" {
#   rest_api_id   = "${aws_api_gateway_rest_api.ip_api.id}"
#   resource_id   = "${aws_api_gateway_resource.root.id}"
#   http_method   = "GET"
#   authorization = "NONE"
# }

# # INTEGRATION 
# resource "aws_api_gateway_integration" "integration" {
#   rest_api_id             = "${aws_api_gateway_rest_api.ip_api.id}"
#   resource_id             = "${aws_api_gateway_resource.root.id}"
#   http_method             = "${aws_api_gateway_method.method.http_method}"
#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = "arn:aws:apigateway:${var.myregion}:lambda:path/2015-03-31/functions/${aws_lambda_function.ip_root.arn}/invocations"
# }

# # Lambda
# # LAMBDA PERMISSION
# # Allows exectution from API gateway
# # source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
# # ^^^ EXAMPLE

# resource "aws_lambda_permission" "apigw_lambda" {
#   statement_id  = "AllowExecutionFromAPIGateway"
#   action        = "lambda:InvokeFunction"
#   function_name = "${aws_lambda_function.ip_root.function_name}"
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.ip_api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.root.path}"
# }