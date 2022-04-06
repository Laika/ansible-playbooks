all: help

help:
	@grep -E '^[a-zA-Z._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install
install:
	ANSIBLE_NOCOWS=1 ansible-playbook -v -i hosts.ini --ask-become-pass playbook.yaml

.PHONY: ansible
ansible:
	sudo apt-add-repository -y -u ppa:ansible/ansible && sudo apt install -y ansible

.PHONY: check
check:
	ANSIBLE_NOCOWS=1 ansible-playbook --check --diff -i hosts.ini playbook.yaml
