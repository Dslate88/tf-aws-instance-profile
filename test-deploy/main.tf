locals {
  iam_name_prefix = "test_deploy"
  stack_name      = "test_iam_role"
  s3_bucket_name  = "account-junk-nonversioned"
}

# TODO: research the dynamic keyword, pass multi inlines
module "iam_role" {
  source          = "./.."
  iam_name_prefix = local.iam_name_prefix
  stack_name      = local.stack_name
  s3_bucket_name  = local.s3_bucket_name
}
