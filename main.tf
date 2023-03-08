

module "vpc_rds" {
  source = "./modules"

  common_cidr_block = var.common_cidr_block

  common_tags = var.common_tags

  private1_cidr_block = var.private1_cidr_block

  private2_cidr_block = var.private2_cidr_block

  public_cidr_block = var.public_cidr_block
}



