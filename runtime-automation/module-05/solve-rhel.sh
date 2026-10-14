#!/bin/sh
echo "Solved module called module-05" >> /tmp/progress.log

cat > /root/soe.yml << 'EOF'
---
- name: Deploy a secure nginx web server
  hosts: localhost
  remote_user: root
  vars:
    podman_quadlet_specs:
      - name: nginx
        type: container
        file_content: |
          [Container]
          Image=registry.access.redhat.com/ubi10/nginx-126:10.0
          PublishPort=8080:8080
          PodmanArgs=--security-opt no-new-privileges
          Exec=/usr/libexec/s2i/run
          Volume=/opt/web/index.html:/opt/app-root/src/index.html:Z
          AutoUpdate=registry
    podman_firewall:
      - port: 8080/tcp
        state: enabled
  pre_tasks:
    - name: Create the web content directory
      ansible.builtin.file:
        path: /opt/web
        state: directory
        mode: '0755'
    - name: Create the web content
      ansible.builtin.copy:
        content: |
          <h1>Super-Business internal web server</h1>
          <p>Served by a systemd-managed nginx container.</p>
        dest: /opt/web/index.html
        mode: '0644'
  roles:
    - role: rhel-system-roles.podman
EOF

ansible-playbook /root/soe.yml
systemctl restart nginx
systemctl enable --now podman-auto-update.timer
systemctl list-timers podman-auto-update.timer
podman auto-update
