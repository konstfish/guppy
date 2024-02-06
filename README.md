# shoal

https://en.wikipedia.org/wiki/Shoaling_and_schooling

k3s ansible playbook for my raspberry cluster

todo: actual k3s part but i only have 1 node rn will prob use the official playbook https://github.com/k3s-io/k3s-ansible

`curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --disable=traefik --flannel-backend=host-gw --tls-san=10.0.1.50 --bind-address=10.0.1.50 --advertise-address=10.0.1.50 --node-ip=10.0.1.50 --write-kubeconfig-mode --cluster-init" sh -s -`