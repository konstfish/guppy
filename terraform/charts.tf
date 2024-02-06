resource "helm_release" "cloudflare_tunnel_ingress_controller" {
  name             = "cloudflare-tunnel-ingress-controller"
  repository       = "https://helm.strrl.dev"
  chart            = "cloudflare-tunnel-ingress-controller"
  namespace        = "cloudflare-tunnel-ingress-controller"
  create_namespace = true


  set {
    name  = "cloudflare.apiToken"
    value = var.cloudflare_api_token
  }

  set {
    name  = "cloudflare.accountId"
    value = var.cloudflare_acount_id
  }

  set {
    name  = "cloudflare.tunnelName"
    value = var.cloudflare_tunnel_name
  }

  timeout = 100
}

resource "helm_release" "nfs_subdir_external_provisioner" {
  name       = "nfs-subdir-external-provisioner"
  repository = "https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/"
  chart      = "nfs-subdir-external-provisioner"
  namespace  = "nfs-provisioner"
  create_namespace = true

  set {
    name  = "nfs.server"
    value = var.nfs_server
  }
  set {
    name  = "nfs.path"
    value = var.nfs_path
  }
  set {
    name = "nfs.nfs.mountOptions"
    value = var.nfs_mount_options
  }

  timeout = 100
}