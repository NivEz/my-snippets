#!/bin/bash

sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli docker-compose-plugin docker-buildx-plugin docker-ce-rootless-extras
sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce docker-ce-cli docker-compose-plugin docker-buildx-plugin docker-ce-rootless-extras

sudo rm -rf /var/lib/docker /etc/docker
sudo rm -f /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock

echo Uninstalled docker completely
