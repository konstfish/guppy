# guppy

https://en.wikipedia.org/wiki/Shoaling_and_schooling

k3s ansible playbook for my raspberry cluster

Still need to figure out how to dynamically assign the roles directory. [k3s-ansible](https://github.com/k3s-io/k3s-ansible) stores playbooks in a playbooks/ directory so ansible assumes the roles are in there as well.

fix for now is to just `mv k3s-ansible/playbooks/* k3s-ansible/`

## Run me
1. Adjust your group vars from the base one in [inventory/group_vars/k3s_cluster.example.yml](inventory/group_vars/k3s_cluster.example.yml)
2. Adjust the [inventory/group_vars/hosts.yml](inventory/group_vars/hosts.yml) file
3. `make install`
4. `cd terraform && terraform init && terraform apply`