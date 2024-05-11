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
  content = templatefile("${path.module}/ansible/inventory.tpl", {
    controller_nodes       = local.controller_nodes,
    worker_nodes           = null,
    k3s_version            = var.cluster_k3s_version,
    token                  = var.cluster_token,
    lb_public_address      = hcloud_load_balancer.lb.ipv4
    cluster_lb_internal_ip = hcloud_load_balancer_network.lb_network.ip
  })
  filename = "${path.module}/ansible/inventory.yml"

  provisioner "local-exec" {
    command     = <<EOT
      sleep 10 # wait for nodes to be ready
      ansible-playbook -i inventory.yml playbook.yml -u pi --private-key=/Users/david/.ssh/id_ansible --extra-vars "kubeconfig_localhost=true kubeconfig_localhost_ansible_host=false"
    EOT
    working_dir = "ansible"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "false"
    }
  }
}

output "controller_node_list" {
  value = local.controller_nodes
}