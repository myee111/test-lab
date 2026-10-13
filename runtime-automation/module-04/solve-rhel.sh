#!/bin/sh
echo "Solved module called module-04" >> /tmp/progress.log

cd /root/podman-lab
ansible-playbook playbook.yml
systemctl status nginx --no-pager
podman ps
curl http://localhost:8080
