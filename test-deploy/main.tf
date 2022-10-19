locals {
  stack_name = "test"
  env        = "dev"

  iam_name_prefix = "test_deploy"
  s3_bucket_name  = "account-junk-nonversioned"
}

module "instance_profile" {
  source               = "./.."
  env                  = local.env
  iam_name_prefix      = local.iam_name_prefix
  stack_name           = local.stack_name
  s3_bucket_name       = local.s3_bucket_name
  addl_policy_document = data.aws_iam_policy_document.additional.json
}

# additional policy merged into module default
data "aws_iam_policy_document" "additional" {
  statement {
    sid = "TestSid"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]
    resources = [
      "arn:aws:s3:::account-keeps-nonversioned/"
    ]
  }
}
