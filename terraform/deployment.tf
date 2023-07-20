resource "kubernetes_deployment" "webserver_deployment" {
  metadata {
    name = "webserver-deployment"
    labels = var.selector
  }

  spec {
    replicas = var.replicas
    selector {
      match_labels = var.selector
    }
    template {
      metadata {
        labels = var.selector
      }
      spec {
        container {
          image = var.container_image
          name  = var.container_name

          port {
            container_port = var.container_port
          }
        }
        image_pull_secrets {
          name = var.image_pull_secret_name
        }
      }
    }
  }
}

resource "kubernetes_service" "webserver_service" {
  metadata {
    name = "webserver-service"
  }
  spec {
    selector = var.selector
    type = "LoadBalancer"
    port {
      port        = var.container_port
      target_port = var.container_port
    }
  }
}
