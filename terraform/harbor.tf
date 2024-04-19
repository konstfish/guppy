/*resource "helm_release" "harbor" {
  name             = "harbor"
  repository       = "https://helm.goharbor.io"
  chart            = "harbor"
  namespace        = "harbor"
  create_namespace = true

  values = [
    file("${path.module}/cluster/helm/harbor/values.yml")
  ]
}*/