module "pipeline" {
  source = "./pipeline"
  source_conf = {
    S3Bucket    = var.source_s3_bucket
    S3ObjectKey = var.source_s3_key
    PollForSourceChanges = true
  }
}