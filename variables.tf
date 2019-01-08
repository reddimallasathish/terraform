#
# AWS Credentials
#
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.aws_region}"
    
  # assume_role {
	#	role_arn     = ""
  # }
}

variable "aws_account_number" {
    default = "105079806215"
}

variable "aws_access_key" {
    default = "AKIAJVYBD3E55ULJ45KQ"
}

variable "aws_secret_key" {
    default = "/tFVwjzP0jFCCKDw+kI5RCSUoURR7eEnZREuH81d"
}

#
# Variables for AWS Environment
#
variable "aws_region" {
    default = "us-east-1"
}

variable "aws_az_1a" {
    default = "us-east-1a"
}

variable "aws_az_1b" {
    default = "us-east-1b"
}

variable "availability_zones" {
    default = "us-east-1a,us-east-1b"
}

variable "aws_name" {
    default = "demo"
}

variable "aws_env" {
    default = "sample"
}

#
# Variables for AMIs
#
variable "aws_amazon_ami" {
    default = {
        us-east-1 = "ami-c58c1dd3"
        us-east-2 = "ami-4191b524"
    }
}

variable "aws_amazon_ecs_ami" {
    default = {
        us-east-1 = "ami-009d6802948d06e52"
        us-east-2 = "ami-009d6802948d06e52"
    }
}

variable "aws_ubuntu_ami" {
    default = {
        us-east-1 = "ami-80861296"
        us-east-2 = "ami-618fab04"
    }
}
#
# Variables for Auto Scaling Group
#
variable "key_name" {
    default     = "sample-demo-key"
    description = "Name of AWS key pair"
}

variable "instance_t2_micro" {
    default     = "t2.micro"
    description = "AWS t2 Micro Instance"
}

variable "instance_t2_small" {
    default     = "t2.micro"
    description = "AWS t2 Small Instance"
}

variable "instance_t2_medium" {
    default     = "t2.medium"
    description = "AWS t2 Medium Instance"
}

variable "instance_m4_large" {
    default     = "m4.large"
    description = "AWS m4 Large Instance"
}

variable "instance_m4_xlarge" {
    default     = "m4.xlarge"
    description = "AWS m4 xLarge Instance"
}

variable "asg_min" {
    default     = "2"
    description = "Min numbers of servers in ASG"
}

variable "asg_max" {
    default     = "4"
    description = "Max numbers of servers in ASG"
}

variable "asg_desired" {
    default     = "2"
    description = "Desired numbers of servers in ASG"
}