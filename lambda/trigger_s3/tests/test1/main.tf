variable "lambda_func_name" {
  type = string
}

variable "s3_name" { 
  type = string
}

variable "filename" {
  type = string
}

data "aws_region" "current" {
}

resource "aws_lambda_invocation" "example" {
  function_name = var.lambda_func_name
  input = templatefile(
    "${path.module}/sample.json.tftpl", {
      region = data.aws_region.current.name,
      s3_name = var.s3_name,
      filename = var.filename,
    })
}

output "results1" {
  value =  aws_lambda_invocation.example.result
}