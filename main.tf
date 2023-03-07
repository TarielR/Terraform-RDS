

module "vpc_rds" {
  source = "./modules"

  common_cidr_block = var.common_cidr_block

  common_tags = var.common_tags

  private_cidr_block = var.private_cidr_block

  public_cidr_block = var.public_cidr_block
}



