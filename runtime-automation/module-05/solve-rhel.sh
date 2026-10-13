#!/bin/sh
echo "Solved module called module-05" >> /tmp/progress.log

cat > /root/podman-lab/playbook.yml << 'EOF'
---
- name: Deploy a secure nginx web server
  hosts: localhost
  become: true
  tasks:
    - name: Manage the nginx quadlet with the podman system role
      ansible.builtin.include_role:
        name: redhat.rhel_system_roles.podman
      vars:
        podman_quadlet_specs:
          - name: nginx
            type: container
            file_content: |
              [Container]
              Image=registry.access.redhat.com/ubi9/nginx-124:1
              PublishPort=8080:8080
              PodmanArgs=--security-opt no-new-privileges
              AutoUpdate=registry
        podman_firewall:
          - port: 8080/tcp
            state: enabled
EOF

cd /root/podman-lab
ansible-playbook playbook.yml
systemctl restart nginx
systemctl enable --now podman-auto-update.timer
systemctl list-timers podman-auto-update.timer
podman auto-update
