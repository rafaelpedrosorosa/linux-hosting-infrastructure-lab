## Parte Opcional - Docker

## Objetivo

Montar um ambiente simples de desenvolvimento utilizando Docker Compose contendo Nginx, PHP-FPM e MariaDB.

## Estrutura

Foram utilizados três containers separados:

* Nginx para receber as requisições HTTP;
* PHP-FPM para processar os arquivos PHP;
* MariaDB para armazenamento dos dados.

A comunicação entre os containers ocorre através da rede criada automaticamente pelo Docker Compose.

## Implementação

O Nginx foi configurado para encaminhar as requisições PHP para o container PHP-FPM utilizando FastCGI.

Foi criado um arquivo `index.php` contendo apenas a função `phpinfo()` para validar o funcionamento da integração entre Nginx e PHP.

Para o banco de dados foi utilizado um volume Docker, garantindo a persistência dos dados mesmo após a recriação dos containers.

## Estrutura do Projeto

```text
.
├── docker-compose.yml
├── mariadb
│   └── data
├── nginx
│   └── default.conf
├── parte1
│   ├── health_check.sh
│   ├── troubleshooting.md
│   └── evidencias
├── php
│   └── index.php
└── README.md
```

## Execução

```bash
docker-compose up -d
```

ou

```bash
docker compose up -d
```

## Validação

Após a execução do ambiente:

```bash
docker ps
```

A aplicação pode ser acessada em:

```text
http://localhost:8080
```

Foi realizado também teste de persistência do MariaDB através da parada e recriação dos containers, confirmando a manutenção dos dados através do volume configurado.
