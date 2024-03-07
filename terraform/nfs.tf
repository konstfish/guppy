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

// variables
variable "nfs_server" {
  description = "The NFS server to use for persistent storage."
  type        = string
  default     = "10.0.1.1"
}

variable "nfs_path" {
  description = "The NFS path to use for persistent storage."
  type        = string
  default     = "/mnt/md0/stor/k3s"
}

variable "nfs_mount_options" {
  description = "The mount options to use for the NFS volume."
  type        = string
  default     = "rw,rsize=32768,wsize=32768,timeo=600"
}