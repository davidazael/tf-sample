# terraform {
#   backend "s3" {
#     bucket         = "s3-tf-state-comcast-sre-challenge"
#     key            = "comcast-sre/s3/terraform.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "tf-state-lock-comcast-sre-challenge"
#     encrypt        = true
#   }
# }

