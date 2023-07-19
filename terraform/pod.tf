resource "kubernetes_deployment" "webserver_deployment" {
  metadata {
    name = "webserver-deployment"
    labels = {
      app = "webserver"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "webserver"
      }
    }
    template {
      metadata {
        labels = {
          app = "webserver"
        }
      }
      spec {
        container {
          image = "117698939310.dkr.ecr.eu-west-1.amazonaws.com/zumo_website:latest"
          name  = "zumo-webserver"

          port {
            container_port = 80
          }
        }
        image_pull_secrets {
          name = "ecr-credentials"
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
    selector = {
      app = "webserver"
    }
    type = "LoadBalancer"
    port {
      port        = 80
      target_port = 80
    }
  }
}
