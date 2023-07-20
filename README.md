# zumo_assesment

## Link to the website:
http://ab772d5b30be9407dac38f1d173f9355-1768069725.eu-west-1.elb.amazonaws.com/
## Infrastructure Overview
This document provides an overview of the current infrastructure setup, which leverages cloud computing, containerization, and Infrastructure as Code (IaC). The setup is primarily based on AWS services, GitHub, and Terraform.

### Workflow
**Local PC:** The development process begins on a local PC, where code is written and then pushed to a GitHub repository.

**GitHub Repository:** It contains both the Terraform code for setting up the AWS environment, the code for the webserver and the code for the backend.

**Terraform via GitHub Action:** Upon code push to the GitHub repository, a GitHub Action triggers the Terraform code. This code sets up the necessary AWS resources, including a VPC, an EKS, a Lambda + API Gateway and a Kubernetes deployment for the webserver.

**Build & Push Image via GitHub Action:** The webserver code in the GitHub repository is built into a Docker image and pushed to the AWS Registry using another GitHub Action.

**S3 Bucket**: This is where the Terraform state file is stored

**AWS Registry:** This is where the Docker image of the webserver is stored.

**Webserver Pod:** The Docker image from the AWS Registry is deployed to the Kubernetes environment in AWS (EKS) as a pod. This deployment process is also handled by a GitHub Action.

**AWS API Gateway:** The API Gateway is deployed via Terraform and exposes the AWS Lambda Backend.

**AWS Lambda Backend:** The webserver pod, once deployed and running, connects to the backend service running on AWS Lambda via the API Gateway.

**AWS CloudWatch:** The webserver pod outputs logs to AWS CloudWatch for monitoring and debugging purposes.


![infra](https://github.com/Yb2411/zumo_assesment/assets/132000325/f4a142d0-61e7-4495-b33a-822935129a2a)


## Technology Choices
The choice of technologies in this setup is driven by the need for automation and efficient resource management.

**AWS:** Amazon Web Services (AWS) is chosen as the cloud provider due to its extensive service offerings, scalability, and reliability.

**GitHub:** GitHub is used for version control, allowing for collaboration, code review, and integration with other tools like GitHub Actions for CI/CD.

**Terraform:** Terraform is the most popular IaC tool. In this scenario, it is used to automate the setup and deployment of the AWS resources (including the webserver).

**Kubernetes (EKS):** Amazon Elastic Kubernetes Service (EKS) is a managed service that makes it easy to run Kubernetes on AWS without needing to install, operate, and maintain your own Kubernetes control plane or nodes. It is used to manage the Docker containers.

**AWS Lambda:** AWS Lambda is a serverless compute service that runs your code in response to events and automatically manages the underlying compute resources for you. It is used to run the backend service that the webserver connects to.

**AWS API Gateway:** Amazon API Gateway is a fully managed service that makes it easy to expose APIs. It is used to expose the AWS Lambda backend.

**AWS CloudWatch:** Amazon CloudWatch is a monitoring and observability service, in this case we chose it because it is easy to setup compared to other tool like ELK or Prometheus that requires more time.

## What could be improved?

This setup serves as a fundamental introduction to DevOps tasks, but there is significant scope for improvement:

- **Backend / Frontend / Terraform Split:** Ideally, these components should be divided into three separate repositories for better tracking of changes.
- **Pre-Prod / Dev Environment:** Currently, we have only one branch in this repository. It would be beneficial to have one or two additional branches per environment, with each environment using specific variables.
- **Secret Management:** While we are currently using GitHub Actions, alternatives such as HashiCorp Vault or AWS Secrets Manager could be used to get better tracking of secret changes (and to dynamically store the backend URL for example).
- **Resiliency:** To increase reliability, we could have multiple instances of the website, each in a different availability zone.
- **Monitoring:** In a production environment, a more sophisticated monitoring tool than CloudWatch would be preferable. Options include the ELK Stack or Prometheus, along with other alerting tools like Heartbeat, Elastalerts, and various dashboarding solutions.
- **CDN Integration:** We could integrate a CDN like CloudFront to make the web server available in various locations with minimal latency.
