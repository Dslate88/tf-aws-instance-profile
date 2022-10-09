variable "iam_name_prefix" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "stack_name" {
  type = string
}

variable "managed_policy_arns" {
  type    = list(string)
  default = []
}
