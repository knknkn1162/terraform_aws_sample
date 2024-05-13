variable "repo" {
  type = string
}
variable "trigger_arn" {
  type = string
}
resource "aws_codecommit_repository" "test" {
  repository_name = var.repo
}

resource "aws_codecommit_trigger" "test" {
  repository_name = aws_codecommit_repository.test.repository_name

  trigger {
    name            = "trigger-${uuid()}"
    events          = ["all"]
    destination_arn = var.trigger_arn
  }
}