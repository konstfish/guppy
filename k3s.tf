locals {
  controller_nodes = [
    {
      name             = "${var.cluster_name}-0"
      ansible_host     = "10.0.1.51"
      ansible_ssh_host = "10.0.1.51"
    },
    {
      name             = "${var.cluster_name}-1"
      ansible_host     = "10.0.1.52"
      ansible_ssh_host = "10.0.1.52"
    },
    {
      name             = "${var.cluster_name}-2"
      ansible_host     = "10.0.1.53"
      ansible_ssh_host = "10.0.1.53"
    }
  ]
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/k3s-ansible/inventory.tpl", {
    controller_nodes = local.controller_nodes,
    worker_nodes     = null,

    ansible_user    = "pi",
    ansible_ssh_key = "/Users/david/.ssh/id_ansible",

    user_name   = "david",
    github_user = "konstfish",

    k3s_version  = "v1.27.6+k3s1",
    k3s_token    = var.cluster_token,
    cluster_name = "guppy",
    cluster_type = "raspberry",

    lb_public_address   = "10.0.1.50"
    lb_internal_address = "10.0.1.50"
    lb_interface        = "eth0"
    lb_port             = 6440

    extra_server_args = ""
    cluster_cidr      = "10.42.0.0/16"
    service_cidr      = "10.43.0.0/16"
  })
  filename = "${path.module}/k3s-ansible/inventory.yml"

  provisioner "local-exec" {
    command     = <<EOT
      sleep 10 # wait for nodes to be ready
      ansible-playbook -i inventory.yml playbook/install.yml --extra-vars "kubeconfig_localhost=true kubeconfig_localhost_ansible_host=false"
    EOT
    working_dir = "k3s-ansible"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "false"
    }
  }
}

output "controller_node_list" {
  value = local.controller_nodes
}