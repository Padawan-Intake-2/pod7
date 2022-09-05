provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.26.6"

  cluster_name    = "${var.namespace}-eks"
  cluster_version = "~> 1.22"

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  eks_managed_node_groups = {
    one = {
      name          = "${var.namespace}-ng"
      instance_type = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
}