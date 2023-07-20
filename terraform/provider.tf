provider "aws" {
  region = var.aws_region
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}


data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

terraform {
  backend "s3" {
    bucket = "zumo-terraform-asses"
    key    = "zumo/terraform.tfstate"
    region = "eu-west-1"
  }
}