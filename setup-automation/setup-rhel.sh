#!/bin/bash

echo "Lab setup starting" > /tmp/progress.log
chmod 666 /tmp/progress.log

usermod -aG wheel rhel

dnf remove -y tmux

# Keep the lab deterministic: disable the image's own automatic updates
systemctl stop dnf-automatic-install.timer
systemctl disable dnf-automatic-install.timer
systemctl mask dnf-automatic-install.timer

systemctl stop dnf-automatic.timer
systemctl disable dnf-automatic.timer

sed -i 's/^apply_updates.*/apply_updates = no/' /etc/dnf/automatic.conf
sed -i 's/^download_updates.*/download_updates = no/' /etc/dnf/automatic.conf

echo "Lab setup complete" >> /tmp/progress.log
