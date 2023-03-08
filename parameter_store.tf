variable "flag" {
  default = "ohh"
}

resource "random_string" "rds_password" {
  length = 10
  special = false
  keepers = {
    keeper = var.flag
  }
}

resource "aws_ssm_parameter" "rds_password" {
  name = "/dev/postgres"
  type = "SecureString"
  value = random_string.rds_password.result
  description = "Master password for Aurora Cluster"
}

data "aws_ssm_parameter" "my_rds_password" {
  name = "/dev/postgres"
  depends_on = [aws_ssm_parameter.rds_password]
}

output "my_rds_password" {
  sensitive = true
  value = data.aws_ssm_parameter.my_rds_password.value
}


