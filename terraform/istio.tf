resource "helm_release" "istio" {
  name             = "istio-base"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "base"
  namespace        = "istio-system"
  create_namespace = true

  set {
    name = "defaultRevision"
    value = "default"
  }
}

resource "helm_release" "istiod" {
  name             = "istiod"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "istiod"
  namespace        = "istio-system"

  set {
    name = "defaults.global.meshID"
    value = "shoal"
  }

  set {
    name = "defaults.global.multiCluster.clusterName"
    value = "guppy"
  }

  set {
    name = "defaults.global.multiCluster.enabled"
    value = true
  }

  set {
    name = "defaults.global.network"
    value = "guppy"
  }

  depends_on = [ helm_release.istio ]
}

resource "helm_release" "istio_ingress" {
  name             = "istio-ingress"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "gateway"
  namespace        = "istio-ingress"
  create_namespace = true

  values = [
    file("${path.module}/cluster/helm/istio/values.yml"),
  ]

  set {
    name  = "controller.service.externalIPs[0]"
    value = data.http.runner_public_ip.response_body
  }

  set {
    name = "defaults.service.loadBalancerIP"
    value = data.http.runner_public_ip.response_body
  }

  depends_on = [ helm_release.istiod ]
}

resource "helm_release" "kiali" {
  name             = "kiali"
  repository       = "https://kiali.org/helm-charts"
  chart            = "kiali-server"
  namespace        = "istio-system"

  depends_on = [ helm_release.istiod ]
}
