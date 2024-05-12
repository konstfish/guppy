provider "kubernetes" {
  config_path = "${path.module}/k3s-ansible/artifacts/guppy.yml"
}

provider "helm" {
  kubernetes {
    config_path = "${path.module}/k3s-ansible/artifacts/guppy.yml"
  }
}