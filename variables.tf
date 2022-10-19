variable "env" {
  type        = string
  description = "[dev/test/prod] identification"
}

variable "s3_bucket_name" {
  type = string
}

variable "stack_name" {
  type        = string
  description = "Name of the stack responsible for deploying the resource"
}

variable "addl_policy_document" {
  type = string
}
