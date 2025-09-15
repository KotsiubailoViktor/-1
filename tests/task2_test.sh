#!/bin/bash

set -e

echo "Running Test for Task 2"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

mkdir -p ~/.config/systemd/user

# Створюємо сервісний файл
cp "${SCRIPT_DIR}/../mytimer.service" ~/.config/systemd/user/mytimer.service

# Створюємо таймерний файл
cp "${SCRIPT_DIR}/../mytimer.timer" ~/.config/systemd/user/mytimer.timer

# Перезавантажуємо systemd для користувача
systemctl --user daemon-reload

# Запускаємо таймер
systemctl --user start mytimer.timer

# Даємо час для роботи таймера
sleep 20

# Перевіряємо виконання
LAST_RUN=$(systemctl show --user -p LastTriggerUSecMonotonic mytimer.timer | cut -d'=' -f2)

if [[ ! "$LAST_RUN" =~ ^[0-9]+$ ]]; then
    echo "Test 2 Passed: mytimer.timer is working."
else
    echo "Test 2 Failed: mytimer.timer did not run."
    exit 1
fi
