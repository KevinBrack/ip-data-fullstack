resource "aws_lambda_function" "ip_root" {
  filename      = "../api/01_root/ip_root_payload.zip"
  function_name = "ip_root"
  role          = "${aws_iam_role.iam_for_ip_lambda.arn}"
  handler       = "exports.handler"
  runtime       = "nodejs10.x"

  source_code_hash = "${filebase64sha256("../api/01_root/ip_root_payload.zip")}"
}
