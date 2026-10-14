#!/bin/sh
echo "Solved module called module-04" >> /tmp/progress.log

ansible-playbook /root/soe.yml
podman --version
systemctl status nginx --no-pager
podman ps
curl http://localhost:8080
