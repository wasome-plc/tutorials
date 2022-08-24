#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "$0")/" && pwd)


if [ -d /wa-plc/ethercat/config ]; then
    sudo mv /wa-plc/ethercat/config /wa-plc/ethercat/config-bak
    echo "saved current ethercat config to folder: /wa-plc/ethercat/config-bak"
fi

if [ -d /wa-plc/ethercat ]; then
    sudo mkdir -p /wa-plc/ethercat
fi

sudo cp -rf is620n /wa-plc/ethercat/config
echo "done."
