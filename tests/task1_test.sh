#!/bin/bash

set -e

echo "Running Test for Task 1"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

mkdir -p ~/.config/systemd/user

# Створюємо сервісний файл
cp "${SCRIPT_DIR}/../myfirst.service" ~/.config/systemd/user/myfirst.service

# Перезавантажуємо systemd для користувача
systemctl --user daemon-reload

# Запускаємо сервіс
systemctl --user start myfirst.service

# Перевіряємо статус сервісу
if systemctl --user is-active --quiet myfirst.service; then
    echo "Test 1 Passed: myfirst.service is active."
else
    echo "Test 1 Failed: myfirst.service is not active."
    exit 1
fi
