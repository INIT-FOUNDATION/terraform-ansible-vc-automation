# COMMON

variable "app_name" {
  description = "Application Name"
  type        = string
}

variable "env" {
  description = "Environment Name"
  type        = string
}

variable "region_name" {
  description = "Region Name"
  type        = string
}


# EC2

variable "servers_count" {
  description = "Servers Count"
  type        = number
}

variable "ami" {
  description = "AMI"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}

variable "key_name" {
  description = "Key Pair Name"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM role for EC2" 
  type        = string
}

variable "root_volume_size" {
  description = "EBS Volume Size"
  type        = number
}

variable "root_volume_iops" {
  description = "EBS volume IOPS"
  type        = number
}

variable "root_volume_throughput" {
  description = "EBS volume throughput"
  type        = number
}

variable "root_volume_kms_key_arn" { 
  description = "EBS Volume KMS key ARN"
  type        = string
}


# ROUTE 53

variable "zone_id" {
  description = "DNS Zone ID"
  type        = string
}

variable "zone_name" {
  description = "DNS Zone Name"
  type        = string
}
