#!/bin/sh
echo "Solved module called module-03" >> /tmp/progress.log

mkdir -p /root/podman-lab
cat > /root/podman-lab/playbook.yml << 'EOF'
---
- name: Deploy a secure nginx web server
  hosts: localhost
  become: true
  tasks:
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
    - name: Manage the nginx quadlet with the podman system role
      ansible.builtin.include_role:
        name: redhat.rhel_system_roles.podman
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
        podman_firewall:
          - port: 8080/tcp
            state: enabled
EOF
