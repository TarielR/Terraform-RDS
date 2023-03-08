output "subnet1" {
  value = module.vpc_rds.subnet_az1
}

output "subnet2" {
  value = module.vpc_rds.subnet_az2
}

output "map_public_ip_on_launch" {
  value = module.vpc_rds.map_public_ip_on_launch
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
