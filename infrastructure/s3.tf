data "aws_caller_identity" "current" {}

module "s3" {
  source = "git::https://github.com/riolaf05/terraform-modules//aws/s3"

  project_info = {
    name   = "rio-fastapi-sns"
    prefix = "rio-fastapi-sns"
    env    = "dev"
  }

  bucket_name      = "documents-bucket"
  ssm_param_prefix = "rio-fastapi-sns"
  bucket_user_arn   = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/rosario.laface"
}

resource "aws_s3_object" "object_raw" {
  bucket = module.s3.bucket_name
  key    = "raw_documents/"
}

resource "aws_s3_object" "object_processed" {
  bucket = module.s3.bucket_name
  key    = "processed_documents/"
}
