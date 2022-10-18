locals {
  iam_name_prefix = "test_deploy"
  stack_name      = "test_iam_role"
  s3_bucket_name  = "account-junk-nonversioned"
}

# TODO i should used stack_name as the naming variable in main.tf
module "iam_role" {
  source               = "./.."
  iam_name_prefix      = local.iam_name_prefix #
  stack_name           = local.stack_name
  s3_bucket_name       = local.s3_bucket_name
  addl_policy_document = data.aws_iam_policy_document.additional.json
}

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
