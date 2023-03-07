variable "flag" {
  default = "ohh"
}

resource "random_string" "rds_password" {
  length = 8
  special = false
  keepers = {
    keeper = var.flag
  }
}

resource "aws_ssm_parameter" "rds_password" {
  name = "/dev/postgres"
  type = "SecureString"
  value = random_string.rds_password.result
}

data "aws_ssm_parameter" "my_rds_password" {
  name = "/dev/postgres"
  depends_on = [aws_ssm_parameter.rds_password]
}

output "my_rds_password" {
  sensitive = true
  value = data.aws_ssm_parameter.my_rds_password.value
}


