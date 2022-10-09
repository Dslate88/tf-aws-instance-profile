locals {
  role_name      = "test_iam_role"
  stack_name     = "test_iam_role"
  s3_bucket_name = "account-junk-nonversioned"
}

# TODO: this repo should be instance-profile renamed
# TODO: research the dynamic keyword, pass multi inlines
module "iam_role" {
  source         = "./.."
  role_name      = local.role_name
  stack_name     = local.stack_name
  s3_bucket_name = local.s3_bucket_name
}
