#!/bin/bash
set -e

NET_NAME="vagrant-libvirt"
XML_PATH="$(pwd)/vagrant-libvirt.xml"

if virsh net-info "$NET_NAME" &>/dev/null; then
  echo "Rede '$NET_NAME' já existe. Pulando criação."
else
  echo "Criando rede $NET_NAME"
  virsh net-define "$XML_PATH"
  virsh net-autostart "$NET_NAME"
  virsh net-start "$NET_NAME"
fi
