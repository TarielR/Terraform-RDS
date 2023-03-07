output "subnet1" {
  value = module.vpc_rds.subnet_az1
}

output "subnet2" {
  value = module.vpc_rds.subnet_az2
}

output "rds_sg_id" {
  value = module.vpc_rds.vpc_sg_id
}

output "rds_sg_name" {
  value = module.vpc_rds.vpc_sg_name
}

output "vpc_tags" {
  value = module.vpc_rds.vpc_name
}
