variable "aws_region" {
  description = "AWS region to launch resources"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "first_subnet_cidr_block" {
  description = "CIDR block for the first subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "second_subnet_cidr_block" {
  description = "CIDR block for the second subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "cluster_kube_zumo"
}

variable "eks_cluster_version" {
  description = "Version of the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "container_image" {
  description = "The Docker image to use for the container"
  type        = string
  default     = "117698939310.dkr.ecr.eu-west-1.amazonaws.com/zumo_website:latest"
}

variable "replicas" {
  description = "The number of replicas for the Kubernetes deployment"
  type        = number
  default     = 2
}

variable "selector" {
  description = "The selector for the Kubernetes deployment and service"
  type        = map(string)
  default     = {
    app = "webserver"
  }
}

variable "container_name" {
  description = "The name of the container"
  type        = string
  default     = "zumo-webserver"
}

variable "container_port" {
  description = "The port that the container exposes"
  type        = number
  default     = 80
}

variable "image_pull_secret_name" {
  description = "The name of the image pull secret"
  type        = string
  default     = "ecr-credentials"
}