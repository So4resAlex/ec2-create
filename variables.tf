variable "availability_zone" {
  description = "Availability zone in which the machine will be launched"
  type        = string
}

variable "instance_type" {
  description = "Type of instance that will be launched"
  type        = string

  validation {
    condition     = contains(["t3.nano", "t3.small", "t2.nano", "t2.small"], var.instance_type)
    error_message = "Invalid instance type. Allowed types are: t3.nano, t3.small, t2.nano, t2.small."
  }
}

variable "key_name" {
  description = "SSH key that will be used to connect to the instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID in which the instance will be launched"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
  default     = null
}

variable "volume_size" {
  description = "Initial size of the EBS"
  type        = number
  validation {
    condition     = var.volume_size <= 25
    error_message = "The volume size must be 25 GB or less"
  }
}

variable "instance_name" {
  description = "Name for the instance that will be created"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}