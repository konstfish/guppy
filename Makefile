install:
	ansible-galaxy install -r requirements.yml

deploy:
	ansible-playbook -i inventory/hosts.yml -b install.yml