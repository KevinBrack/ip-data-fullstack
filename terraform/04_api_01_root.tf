variable "zip_01_root" {
  default = "../api/01_root/ip_root_payload.zip"
}

resource "aws_lambda_function" "root" {
  filename      = "${var.zip_01_root}"
  function_name = "ip_root"
  role          = "${aws_iam_role.ip_lambda_role.arn}"
  handler       = "exports.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = "${filebase64sha256("${var.zip_01_root}")}"

  runtime = "nodejs10.x"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id = "AllowIpApiInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.root.function_name}"
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.IpApi.execution_arn}/*/*/*"
}