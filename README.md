# Laboratório de Infraestrutura Linux para Hospedagem Web

Projeto prático de infraestrutura Linux voltado à sustentação de ambientes de hospedagem web, reunindo troubleshooting, automação com Bash, gerenciamento de configuração com Puppet, análise de entregabilidade de e-mails e execução de serviços em containers.

## Objetivo

Demonstrar conhecimentos aplicados em administração de servidores Linux e hospedagem web, incluindo:

* Diagnóstico de erros HTTP 502 em Nginx e PHP-FPM
* Criação automatizada de ambientes de hospedagem
* Gerenciamento de configuração com Puppet
* Investigação de problemas de e-mail com Exim
* Validação de SPF, DKIM, DMARC e PTR/rDNS
* Conteinerização com Nginx, PHP-FPM e MariaDB

## Estrutura

### Módulo 1  - Troubleshooting Linux e HTTP 502

Documentação de troubleshooting para erro 502 em ambiente Nginx + PHP-FPM e implementação de script de health check.

Local: `parte1/`

### Módulo 2 - Automação de hospedagem com Basht

Script para criação automatizada de ambientes de hospedagem compartilhada com Nginx.

Local: `parte2/`

### Módulo 3  - Gerenciamento de configuração com Puppet

Respostas conceituais e exemplo de manifest Puppet para gerenciamento do Nginx.

Local: `parte3/`

### Módulo 4 - E-mail e entregabilidade com Exim

Documentação da abordagem de investigação de problemas de entrega de e-mails.

Local: `parte4/`

### Módulo Opcional - Ambiente conteinerizado

Ambiente de desenvolvimento utilizando Nginx, PHP-FPM e MariaDB através de Docker Compose.

Local: `opcional-docker/`

## Ambiente Utilizado

* Ubuntu 22.04.5 LTS
* Nginx
* PHP-FPM
* MariaDB
* Docker Compose
* Bash
* Git

## Observação

Cada parte possui seu próprio README com detalhes da implementação, execução e evidências.

