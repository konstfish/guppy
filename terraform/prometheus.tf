resource "helm_release" "prometheus_stack" {
  name             = "prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true

  values = [
    file("${path.module}/cluster/helm/prometheus-stack/values.yml")
  ]
}

resource "helm_release" "grafana_tempo" {
  name       = "tempo"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "tempo"
  namespace  = "monitoring"

  values = [
    file("${path.module}/cluster/helm/tempo/values.yml")
  ]

  depends_on = [
    helm_release.prometheus_stack
  ]
}