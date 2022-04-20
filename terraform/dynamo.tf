resource "aws_dynamodb_table" "tf_dynamo_locks" {
  name         = var.dynamo_tb_name
  billing_mode = var.dynamo_bill_mode
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.tags
}
