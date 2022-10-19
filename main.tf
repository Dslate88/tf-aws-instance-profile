resource "aws_iam_instance_profile" "main" {
  name = "${var.iam_name_prefix}_profile"
  role = aws_iam_role.instance.name
  tags = {
    Stack = var.stack_name,
    Env   = var.env
  }
}

resource "aws_iam_role" "instance" {
  name               = "${var.iam_name_prefix}_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  inline_policy {
    name   = "policy-inline-1"
    policy = data.aws_iam_policy_document.combined.json
  }
  tags = {
    Stack = var.stack_name,
    Env   = var.env
  }
}

resource "aws_iam_policy" "instance" {
  name        = "${var.iam_name_prefix}_policy"
  path        = "/"
  description = "${var.stack_name}_policy for instance profile"
  policy      = data.aws_iam_policy_document.combined.json
  tags = {
    Stack = var.stack_name,
    Env   = var.env
  }
}

data "aws_iam_policy_document" "combined" {
  source_policy_documents = [
    data.aws_iam_policy_document.default.json,
    var.addl_policy_document
  ]
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    sid = "AssumeEc2"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "default" {
  statement {
    sid = "Default"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]
    resources = [
      "arn:aws:s3:::*",
    ]
  }
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}",
    ]
    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values = [
        "",
        "ec2/",
        "ec2/${var.stack_name}",
      ]
    }
  }
  statement {
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/ec2/${var.stack_name}",
      "arn:aws:s3:::${var.s3_bucket_name}/ec2/${var.stack_name}/*",
    ]
  }
}
