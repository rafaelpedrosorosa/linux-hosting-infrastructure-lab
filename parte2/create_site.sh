#!/bin/bash

DOMAIN="$1"
LOGFILE="./logs/create_site.log"

if [ -z "$DOMAIN" ]; then
    echo "Uso: sudo ./create_site.sh dominio.com.br"
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
    echo "Execute com sudo."
    exit 1
fi

mkdir -p ./logs

USER_NAME=$(echo "$DOMAIN" | tr '.-' '_' | tr '[:upper:]' '[:lower:]')
WEB_ROOT="/home/$USER_NAME/public_html"
VHOST_FILE="/etc/nginx/sites-available/$DOMAIN"
VHOST_LINK="/etc/nginx/sites-enabled/$DOMAIN"

log() {
    echo "$(date '+%F %T') - $1" | tee -a "$LOGFILE"
}

log "Iniciando configuração para $DOMAIN"

if ! id "$USER_NAME" >/dev/null 2>&1; then
    useradd -m -s /usr/sbin/nologin "$USER_NAME"
    log "Usuário criado: $USER_NAME"
else
    log "Usuário já existe: $USER_NAME"
fi

mkdir -p "$WEB_ROOT"
chown -R "$USER_NAME:www-data" "/home/$USER_NAME"
chmod 750 "/home/$USER_NAME"
chmod 755 "$WEB_ROOT"

log "Diretório configurado: $WEB_ROOT"

if [ ! -f "$WEB_ROOT/index.html" ]; then
    cat > "$WEB_ROOT/index.html" <<EOF
<h1>$DOMAIN</h1>
<p>Ambiente criado automaticamente.</p>
EOF
    chown "$USER_NAME:www-data" "$WEB_ROOT/index.html"
    chmod 644 "$WEB_ROOT/index.html"
    log "Arquivo index.html criado"
else
    log "Arquivo index.html já existe"
fi

cat > "$VHOST_FILE" <<EOF
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;

    root $WEB_ROOT;
    index index.html index.php;

    access_log /var/log/nginx/${DOMAIN}_access.log;
    error_log /var/log/nginx/${DOMAIN}_error.log;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

log "Virtual host gerado: $VHOST_FILE"

if [ ! -L "$VHOST_LINK" ]; then
    ln -s "$VHOST_FILE" "$VHOST_LINK"
    log "Virtual host ativado"
else
    log "Virtual host já estava ativo"
fi

if nginx -t; then
    systemctl reload nginx
    log "Nginx validado e recarregado"
else
    log "Erro na validação do Nginx"
    exit 1
fi

log "Finalizado para $DOMAIN"
