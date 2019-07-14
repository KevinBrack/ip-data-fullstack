resource "aws_api_gateway_rest_api" "IpApi" {
  name        = "IpApi"
  description = "API for ip information"
}

resource "aws_api_gateway_deployment" "IpApiDeployment" {
  depends_on  = ["aws_api_gateway_integration.int_root_post"]
  rest_api_id = "${aws_api_gateway_rest_api.IpApi.id}"
  stage_name  = "experimental"
}
