variable "aws_region" {
  description = "The designated AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_windows" {
  description = "This is the windows ami"
  type        = string
  default     = "ami-0e38fa17744b2f6a5"
}

variable "ami_linux" {
  description = "This is the linux ami"
  type        = string
  default     = "ami-0dfcb1ef8550277af"
}

variable "aws_availability_zone" {
  description = "The AWS availibility zone"
  type        = string
  default     = "us-east-1e"
}

variable "instance_type" {
  description = "The AWS instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name_windows" {
  description = "Tis is the Key_pair for windows"
  type        = string
  default     = "AUE1-WINDOWS-SERVER"
}

variable "key_name_linux" {
  description = "Tis is the Key_pair for linux"
  type        = string
  default     = "AUE1-WEB-LINUX"
}

variable "security_groups_linux" {
  description = "This is the security group that allow ssh and http"
  default     = ["launch-SSH-ACCESS"]
}

variable "security_groups_Windows" {
  description = "This is the security group that allow RDP and http"
  default     = ["launch-wizard-1"]
}