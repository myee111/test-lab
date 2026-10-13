#!/bin/sh
echo "Validating module called module-02" >> /tmp/progress.log

if ! rpm -q rhel-system-roles > /dev/null 2>&1; then
    echo "FAIL: The rhel-system-roles package is not installed. Run: dnf -y install rhel-system-roles"
    exit 1
fi

if ! [ -d /usr/share/ansible/roles/rhel-system-roles.podman ]; then
    echo "FAIL: The podman system role was not found in /usr/share/ansible/roles/"
    exit 1
fi

echo "PASS: rhel-system-roles is installed and the podman role is available"
exit 0
