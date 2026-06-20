# Troubleshooting - Erro 502 Bad Gateway

## Diagnóstico

Em caso de erro **502 Bad Gateway**, os seguintes comandos podem ser utilizados para identificar a causa do problema:

### Verificar status dos serviços

```bash
systemctl status nginx
systemctl status php8.1-fpm
```

### Consultar logs dos serviços

```bash
journalctl -u nginx
journalctl -u php8.1-fpm
```

### Verificar logs de erro do Nginx

```bash
tail -f /var/log/nginx/error.log
```

### Verificar portas em escuta

```bash
ss -tulpn
```

### Verificar processos ativos

```bash
ps aux | grep -E 'nginx|php-fpm'
```

---

## Principais causas de erro 502

### 1. PHP-FPM parado

O Nginx depende do PHP-FPM para processar arquivos PHP. Caso o serviço esteja parado, o Nginx retornará erro 502.

Validação:

```bash
systemctl status php8.1-fpm
```

Correção:

```bash
sudo systemctl restart php8.1-fpm
```

---

### 2. Socket ou upstream incorreto

O Nginx pode estar configurado para utilizar um socket inexistente ou uma porta incorreta para comunicação com o PHP-FPM.

Validação:

```bash
ls -l /run/php/
grep fastcgi_pass /etc/nginx/sites-enabled/*
```

Correção:

Ajustar a diretiva `fastcgi_pass` para apontar para o socket ou porta corretos e recarregar o Nginx.

```bash
sudo systemctl reload nginx
```

---

### 3. Aplicação PHP travada ou com erro

Falhas na aplicação podem impedir o PHP-FPM de responder adequadamente ao Nginx.

Validação:

```bash
tail -f /var/log/nginx/error.log
journalctl -u php8.1-fpm
```

Correção:

Identificar e corrigir o erro da aplicação e reiniciar o PHP-FPM se necessário.

```bash
sudo systemctl restart php8.1-fpm
```

---

## Health Check

O projeto inclui o script `health_check.sh`, responsável por verificar:

* Status do Nginx;
* Status do PHP-FPM;
* Status do MariaDB;
* Disponibilidade da aplicação via HTTP.

Execução:

```bash
sudo ./health_check.sh
```

Consulta do log:

```bash
sudo tail -f /var/log/health_check.log
```


