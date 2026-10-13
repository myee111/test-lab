#!/bin/sh
echo "Validating module called module-04" >> /tmp/progress.log

if ! [ -f /etc/containers/systemd/nginx.container ]; then
    echo "FAIL: /etc/containers/systemd/nginx.container not found. Run the playbook: ansible-playbook ~/podman-lab/playbook.yml"
    exit 1
fi

if ! systemctl is-active --quiet nginx.service; then
    echo "FAIL: The nginx service is not running. Check: systemctl status nginx"
    exit 1
fi

if ! curl -sf http://localhost:8080/ > /dev/null; then
    echo "FAIL: http://localhost:8080 did not respond. Check: podman ps"
    exit 1
fi

echo "PASS: The nginx quadlet is deployed and serving on port 8080"
exit 0
