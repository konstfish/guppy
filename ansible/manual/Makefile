requirements:
	ansible-galaxy install -r requirements.yml

install:
	ansible-playbook -i inventory/hosts.yml -b install.yml

uninstall:
	ansible-playbook -i inventory/hosts.yml -b uninstall.yml

upgrade:
	ansible-playbook -i inventory/hosts.yml -b upgrade.yml

dev:
	ansible-playbook -i inventory/hosts.yml -b dev.yml
