#!/bin/bash

set -e

echo "Running Test for Task 4"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

# Створюємо сервісний файл
mkdir -p ~/.config/systemd/user

cp "${SCRIPT_DIR}/../myrestart.service" ~/.config/systemd/user/myrestart.service

# Перезавантажуємо systemd для користувача
systemctl --user daemon-reload

# Запускаємо сервіс
systemctl --user start myrestart.service

kill -9 $(systemctl show --user --property MainPID --value myrestart.service)

sleep 5

# Перевіряємо кількість перезапусків
RESTARTS=$(systemctl --user show -p NRestarts myrestart.service | cut -d= -f2)

if [ "$RESTARTS" -ge "1" ]; then
    echo "Test 4 Passed: myrestart.service restarted $RESTARTS times."
else
    echo "Test 4 Failed: myrestart.service did not restart."
    exit 1
fi
