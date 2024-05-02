variable "source_dir" {
  type = string
}

data "archive_file" "zip" {
    type          = "zip"
    source_dir = var.source_dir
    output_path   = "main.zip"
}

output "base64sha256" {
    value = data.archive_file.zip.output_base64sha256
}

output "path" {
    value = data.archive_file.zip.output_path
}