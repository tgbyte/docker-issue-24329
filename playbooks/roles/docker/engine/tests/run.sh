#!/bin/bash -l

set -e

cd /etc/ansible/roles

# create tar to install dependencies
tar czf ../role-test role

# install role via ansible-galaxy
cd ..
ansible-galaxy install -f role-test

cd roles/role-test

ansible-playbook -i tests/inventory tests/test.yml --syntax-check
ansible-playbook -i tests/inventory tests/test.yml --connection=local --sudo
ansible-playbook -i tests/inventory tests/test.yml --connection=local --sudo \
      | grep -q 'changed=0.*failed=0' \
      && (echo 'Idempotence test: pass' && exit 0) \
      || (echo 'Idempotence test: fail' && exit 1)
