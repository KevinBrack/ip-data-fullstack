resource "aws_s3_bucket" "investigateip" {
  bucket = "www.investigateip.net"
  acl    = "public-read"
  policy = "${file("policy_json/s3_policy.json")}"

  website {
    index_document = "index.html"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://1gr9avh006.execute-api.us-east-2.amazonaws.com", "https://www.investigateip.net"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
