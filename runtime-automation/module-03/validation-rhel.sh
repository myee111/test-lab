#!/bin/sh
echo "Validating module called module-03" >> /tmp/progress.log

if ! [ -f /root/podman-lab/playbook.yml ]; then
    echo "FAIL: /root/podman-lab/playbook.yml not found. Create the playbook (see module 3)."
    exit 1
fi

if ! grep -q "podman_quadlet_specs" /root/podman-lab/playbook.yml; then
    echo "FAIL: The playbook does not define podman_quadlet_specs."
    exit 1
fi

if ! grep -q "registry.access.redhat.com/ubi9/nginx-124" /root/podman-lab/playbook.yml; then
    echo "FAIL: The quadlet does not pull the nginx image from registry.access.redhat.com."
    exit 1
fi

echo "PASS: The playbook defines the nginx quadlet"
exit 0
