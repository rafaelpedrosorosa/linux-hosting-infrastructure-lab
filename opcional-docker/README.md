# Parte Opcional - Docker

## Objetivo

Criar um ambiente de desenvolvimento local utilizando Docker Compose contendo Nginx, PHP-FPM e MariaDB.

## Arquivos Entregues

* `docker-compose.yml` – Definição dos serviços Nginx, PHP-FPM e MariaDB.
* `nginx/default.conf` – Configuração do Virtual Host Nginx.
* `php/index.php` – Página de teste utilizando `phpinfo()`.
* `mariadb/data/` – Diretório utilizado para persistência dos dados do MariaDB.

## Implementação

O ambiente foi dividido em três containers:

* Nginx para recebimento das requisições HTTP.
* PHP-FPM para processamento dos arquivos PHP.
* MariaDB para armazenamento dos dados da aplicação.

A comunicação entre os containers ocorre através da rede criada automaticamente pelo Docker Compose.

A persistência dos dados do MariaDB foi implementada através de volume, garantindo que as informações permaneçam disponíveis após reinicializações ou recriações dos containers.

## Execução

```bash
docker compose up -d
```

## Validação

Após a inicialização dos containers foi possível acessar a aplicação e visualizar a página gerada pelo comando `phpinfo()`, confirmando a integração entre Nginx e PHP-FPM.

Também foi validada a persistência dos dados do MariaDB através do volume configurado no Docker Compose.

