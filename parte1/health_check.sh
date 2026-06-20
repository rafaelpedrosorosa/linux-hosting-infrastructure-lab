#!/bin/bash

LOG_FILE="/var/log/health_check.log"
PHP_FPM_SERVICE=$(systemctl list-units --type=service --all | grep -oE 'php[0-9]+\.[0-9]+-fpm' | head -1)

echo "=== $(date) ===" >> "$LOG_FILE"

if systemctl is-active --quiet nginx; then
    echo "nginx online" >> "$LOG_FILE"
else
    echo "nginx offline" >> "$LOG_FILE"
fi

if systemctl is-active --quiet $PHP_FPM_SERVICE; then
    echo "$PHP_FPM_SERVICE online" >> "$LOG_FILE"
else
    echo "$PHP_FPM_SERVICE offline" >> "$LOG_FILE"
fi

if systemctl is-active --quiet mariadb; then
    echo "mariadb online" >> "$LOG_FILE"
else
    echo "mariadb offline" >> "$LOG_FILE"
fi

if curl -fsS http://localhost >/dev/null; then
    echo "site online" >> "$LOG_FILE"
else
    echo "site offline" >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"
