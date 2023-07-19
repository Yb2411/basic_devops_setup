module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "cluster_kube_zumo"
  cluster_version = "1.27"
  subnet_ids      = [aws_subnet.first_subnet.id, aws_subnet.second_subnet.id]
  vpc_id          = aws_vpc.my_vpc.id

  cluster_endpoint_public_access  = true

  eks_managed_node_groups = {
    green = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t2.small"]
      capacity_type  = "ON_DEMAND"
    }
  }
}