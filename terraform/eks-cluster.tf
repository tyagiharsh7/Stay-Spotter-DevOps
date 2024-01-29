module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name = "stayspotter-eks"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  subnet_ids = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id

  tags = {
    environment = "prod"
    application = "stayspotter"
  }

  eks_managed_node_groups = {
    prod = {
        min_size = 1
        max_size = 2
        desired_size = 2

        instance_type = ["t3.micro"]
    }
  }
}