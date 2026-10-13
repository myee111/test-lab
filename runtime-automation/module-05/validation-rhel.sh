#!/bin/sh
echo "Validating module called module-05" >> /tmp/progress.log

if ! grep -q "^AutoUpdate=registry" /etc/containers/systemd/nginx.container 2>/dev/null; then
    echo "FAIL: The nginx quadlet does not set AutoUpdate=registry. Update the playbook and re-run it."
    exit 1
fi

if ! systemctl is-enabled --quiet podman-auto-update.timer 2>/dev/null; then
    echo "FAIL: podman-auto-update.timer is not enabled. Run: systemctl enable --now podman-auto-update.timer"
    exit 1
fi

if ! systemctl is-active --quiet nginx.service; then
    echo "FAIL: The nginx service is not running."
    exit 1
fi

echo "PASS: Automatic container updates are configured and enabled"
exit 0
