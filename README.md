# Практика 01: Основи Systemd

Задача 1:
Створіть простий systemd-сервіс, який запускає команду при старті системи. Сервіс повинен називатися `myfirst.service` і запускати команду `/bin/bash -c 'sleep infinity'`.

---

Задача 2:
Створіть systemd-таймер, який запускає команду `/usr/bin/echo "My Timer Service ran at $(date)"` після запуску системи та кожні 10 секунд після останнього виконання. Таймер повинен називатися `mytimer.timer`.

---

Задача 3:
Створіть systemd-сервіс `mydependent.service`, який залежить від цілі `network.target`. Сервіс повинен запускатися після того, як мережа стає доступною і запускати команду `/bin/bash -c 'sleep infinity'`.

---

Задача 4:
Створіть systemd-сервіс `myrestart.service`, який автоматично перезапускається __при збої__. Сервіс повинен запускати команду `/bin/bash -c 'sleep infinity'`.

---

Задача 5:
Створіть systemd-сервіс `myenv.service`, який встановлює змінну середовища `MY_VARIABLE` зі значенням `HelloWorld` для свого процесу. Сервіс повинен запускати команду `/bin/bash -c 'sleep infinity'`.

---

> Примітка 1: Всі завдання можна виконати використовуючи вашу персональну директорію для юнітів `~/.config/systemd/user/` і відповідно виконувати команди з флагом `--user`, наприклад `systemctl --user daemon-reload`

> Примітка 2: Після завершення видаліть всі файли з директорії юнітів та перезавантажте systemd, щоб в системі не накопичувались зайві процеси.
```bash
rm ~/.config/systemd/user/my*.*
systemctl --user daemon-reload
systemctl --user list-units --no-legend --no-pager --state="not-found" | awk '$3=="not-found" {print $2}' | grep "^my" | xargs systemctl --user stop
systemctl --user reset-failed
```