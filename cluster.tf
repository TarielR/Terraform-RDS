resource "aws_rds_global_cluster" "global" {
  global_cluster_identifier = "aurora-global"
  engine                    = "aurora-postgresql"
  engine_version            = "14.4"
  database_name             = "example"
}

resource "aws_rds_cluster" "postgresql" {
  global_cluster_identifier = aws_rds_global_cluster.global.id
  cluster_identifier      = "aurora-cluster"
  engine                  = aws_rds_global_cluster.global.engine
  engine_version          = aws_rds_global_cluster.global.engine_version
  vpc_security_group_ids  = [module.vpc_rds.vpc_sg_id]
  availability_zones      = ["us-east-1b", "us-east-1c"]
  database_name           = var.db_name
  skip_final_snapshot     = "true"
  master_username         = "foo"
  master_password         = data.aws_ssm_parameter.my_rds_password.value
  backup_retention_period = 1
  preferred_backup_window = "07:00-09:00"
  apply_immediately       = true
  db_subnet_group_name    = aws_db_subnet_group.dbsg.name
  depends_on = [aws_ssm_parameter.rds_password, aws_db_subnet_group.dbsg]
}

resource "aws_db_subnet_group" "dbsg" {
  name = "rds_subnet_group"
  subnet_ids = [module.vpc_rds.vpc_subnet1, module.vpc_rds.vpc_subnet2]
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = length(aws_db_subnet_group.dbsg.subnet_ids)
  identifier         = "instance-${count.index}"
  cluster_identifier = aws_rds_cluster.postgresql.id
  instance_class     = "db.r5.large"
  engine             = aws_rds_cluster.postgresql.engine
  engine_version     = aws_rds_cluster.postgresql.engine_version
  depends_on = [aws_db_subnet_group.dbsg]
}


###########################
//variable "db_name" {
//  type = string
//  default = "my_cluster"
//}

###########################
output "db_subnet_group_id" {
  value = aws_db_subnet_group.dbsg.subnet_ids
}

//output "cluster_availability_zones" {
//  value = aws_rds_cluster.postgresql.availability_zones
//}
//
//output "cluster_port" {
//  value = aws_rds_cluster.postgresql.port
//}
//
//output "db_subnet_group_name" {
//  value = aws_rds_cluster.postgresql.db_subnet_group_name
//}
//
//output "cluster_endpoint" {
//  value = aws_rds_cluster.postgresql.endpoint
//}
//
//output "cluster_members" {
//  value = aws_rds_cluster.postgresql.cluster_members
//}


