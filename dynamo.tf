resource "aws_dynamodb_table" "your_table_resource_name" {
  name           = "your_dynamo_table_name"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "your_partition_key"
  range_key      = "your_sort_key"

  attribute {
    name = "your_partition_key"
    type = "S"
  }

  attribute {
    name = "your_sort_key"
    type = "S"
  }
}
