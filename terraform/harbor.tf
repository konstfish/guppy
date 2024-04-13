resource "helm_release" "harbor" {
  name             = "harbor"
  repository       = "https://helm.goharbor.io"
  chart            = "harbor"
  namespace        = "harbor"
  create_namespace = true

  set {
    name  = "expose.ingress.hosts.core"
    value = "harbor.konst.fish"
  }

  set {
    name  = "expose.tls.secret.secretName"
    value = "harbor-tls"
  }

  set {
    name  = "expose.ingress.harbor.annotations.external-dns\\.alpha\\.kubernetes\\.io/hostname"
    value = "harbor.konst.fish"
  }

  set {
    name  = "externalURL"
    value = "https://harbor.konst.fish"
  }

  set {
    name  = "persistence.imageChartStorage.filesystem.rootdirectory"
    value = "/stor/harbor"
  }

  values = [
    file("${path.module}/cluster/helm/harbor/values.yml")
  ]
}