provider "kubernetes" {
  config_path = "k3s.yaml"
}

provider "helm" {
  kubernetes {
    config_path = "k3s.yaml"
  }
}