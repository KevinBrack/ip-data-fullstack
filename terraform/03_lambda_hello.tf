resource "aws_lambda_function" "ip_hello_world" {
  filename      = "../api/01_hello_world/ip_hello_world_payload.zip"
  function_name = "ip_hello_world"
  role          = "${aws_iam_role.iam_for_ip_lambda.arn}"
  handler       = "exports.handler"

  source_code_hash = "${filebase64sha256("../api/01_hello_world/ip_hello_world_payload.zip")}"

  runtime = "nodejs10.x"

}
