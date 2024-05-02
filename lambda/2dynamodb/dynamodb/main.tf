variable "name" {
  type = string
}

resource "aws_dynamodb_table" "example" {
  name           = var.name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "Id"

  attribute {
    name = "Id"
    type = "S"
  }
}

output "id" {
  value = aws_dynamodb_table.example.id
}

output "name" {
  value = aws_dynamodb_table.example.name
}

output "hash" {
  value = aws_dynamodb_table.example.hash_key
}