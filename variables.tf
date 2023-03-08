variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "db_name" {
  type = string
  default = "my_cluster"
}

variable "common_cidr_block" {
  default = "10.0.0.0/24"
}

variable "public_cidr_block" {
  default = "10.0.0.0/25"
}

variable "private1_cidr_block" {
  default = "10.0.0.128/26"
}

variable "private2_cidr_block" {
  default = "10.0.0.192/26"
}

variable "allow_ports" {
  type    = list(any)
  default = ["80", "22"]
}

variable "enable_detailed_monitoring" {
  type    = bool
  default = false
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(any)
  default = {
    Name    = "RDS"
    Owner   = "Tariel"
  }
}
