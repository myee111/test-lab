#!/bin/sh
echo "Validating module called module-03" >> /tmp/progress.log

if ! [ -f /root/soe.yml ]; then
    echo "FAIL: /root/soe.yml not found. Create the playbook (see module 3)."
    exit 1
fi

if ! grep -q "podman_quadlet_specs" /root/soe.yml; then
    echo "FAIL: The playbook does not define podman_quadlet_specs."
    exit 1
fi

if ! grep -q "registry.access.redhat.com/ubi10/nginx-126" /root/soe.yml; then
    echo "FAIL: The quadlet does not pull the nginx image from registry.access.redhat.com."
    exit 1
fi

if ! grep -q "rhel-system-roles.podman" /root/soe.yml; then
    echo "FAIL: The playbook does not include the rhel-system-roles.podman role."
    exit 1
fi

echo "PASS: The playbook defines the nginx quadlet and uses the podman system role"
exit 0
