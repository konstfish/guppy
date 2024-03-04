resource "helm_release" "rancher" {
  name       = "rancher"
  repository = "https://releases.rancher.com/server-charts/latest"
  chart      = "rancher"
  namespace  = "cattle-system"
  create_namespace = true

  values = [
    file("${path.module}/helm/rancher/values.yml")
  ] 
}

resource "kubernetes_ingress_v1" "rancher" {
  metadata {
    name      = "rancher"
    namespace = "cattle-system"
    annotations = {
      "cloudflare-tunnel-ingress-controller.strrl.dev/backend-protocol" = "https"
    }
  }

  spec {
    ingress_class_name = "cloudflare-tunnel"

    rule {
      host = "rancher.konst.fish"
      http {
        path {
          backend {
            service {
              name = "rancher"
              port {
                number = 443
              }
            }
          }

          path     = "/"
          path_type = "Prefix"
        }
      }
    }
  }

  depends_on = [ 
    helm_release.rancher
   ]
}