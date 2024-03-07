resource "kubernetes_namespace" "longhorn_system" {
  metadata {
    name = "longhorn-system"
    labels = {
      "field.cattle.io/projectId" = "system"
    }
    annotations = {
      "management.cattle.io/system-namespace" : "true"
    }
  }
}

resource "kubernetes_secret" "longhorn_backup_secret" {
  metadata {
    name      = "longhorn-backup-secret"
    namespace = "longhorn-system"
  }

  data = {
    AWS_ACCESS_KEY_ID     = var.longhorn_s3_access_key
    AWS_SECRET_ACCESS_KEY = var.longhorn_s3_secret_key
    AWS_ENDPOINTS         = var.longhorn_s3_endpoint
  }

  type = "Opaque"

  depends_on = [kubernetes_namespace.longhorn_system]
}

resource "helm_release" "longhorn" {
  name       = "longhorn"
  repository = "https://charts.longhorn.io"
  chart      = "longhorn"
  namespace  = "longhorn-system"

  set {
    name  = "defaultSettings.backupTarget"
    value = var.longhorn_s3_bucket
  }

  set {
    name  = "defaultSettings.backupTargetCredentialSecret"
    value = kubernetes_secret.longhorn_backup_secret.metadata[0].name
  }

  depends_on = [kubernetes_namespace.longhorn_system, kubernetes_secret.longhorn_backup_secret]
}


// NFS

resource "kubernetes_namespace" "nfs_provisioner" {
  metadata {
    name = "nfs-provisioner"
    labels = {
      "field.cattle.io/projectId" = "system"
    }
    annotations = {
      "management.cattle.io/system-namespace" : "true"
    }
  }
}

resource "helm_release" "nfs_subdir_external_provisioner" {
  name       = "nfs-subdir-external-provisioner"
  repository = "https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/"
  chart      = "nfs-subdir-external-provisioner"
  namespace  = "nfs-provisioner"

  set {
    name  = "nfs.server"
    value = var.nfs_server
  }
  set {
    name  = "nfs.path"
    value = var.nfs_path
  }
  set {
    name  = "nfs.nfs.mountOptions"
    value = var.nfs_mount_options
  }

  timeout = 100

  depends_on = [
    kubernetes_namespace.nfs_provisioner
  ]
}