#!/bin/bash

set -e

echo "Running Test for Task 5"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

# Створюємо сервісний файл
mkdir -p ~/.config/systemd/user

cp "${SCRIPT_DIR}/../myenv.service" ~/.config/systemd/user/myenv.service

# Перезавантажуємо systemd для користувача
systemctl --user daemon-reload

# Запускаємо сервіс
systemctl --user start myenv.service

VAR_KEY=$(systemctl show --user --property Environment --value myenv.service | cut -d= -f1)
VAR_VALUE=$(systemctl show --user --property Environment --value myenv.service | cut -d= -f2)

# Перевіряємо, чи встановлена змінна
if [ "$VAR_KEY" = "MY_VARIABLE" ] && [ "$VAR_VALUE" = "HelloWorld" ]; then
    echo "Test 5 Passed: Environment variable is set."
else
    echo "Test 5 Failed: Environment variable is not set."
    exit 1
fi
