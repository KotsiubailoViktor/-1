#!/bin/bash

set -e

echo "Running Test for Task 3"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

# Створюємо сервісний файл
mkdir -p ~/.config/systemd/user

cp "${SCRIPT_DIR}/../mydependent.service" ~/.config/systemd/user/mydependent.service

# Перезавантажуємо systemd для користувача
systemctl --user daemon-reload

# Запускаємо сервіс
systemctl --user start mydependent.service

# Перевіряємо статус сервісу
if systemctl show --user --property After mydependent.service | grep network.target -q; then
    echo "Test 3 Passed: mydependent.service is active."
else
    echo "Test 3 Failed: mydependent.service is not active."
    exit 1
fi
