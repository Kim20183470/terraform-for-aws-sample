variable "aws_region" {
  type        = string
  description = "Please input your [Region]"
  default     = "ap-northeast-2"
  validation {
    condition     = contains(["ap-south-1"], var.aws_region)
    error_message = "You must use [ap-south-1]"
  }
}

variable "aws_access_key" {
  type        = string
  description = "Please input your [AWS Access Key]"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "Please input your [AWS Secret Key]"
  sensitive   = true
}
