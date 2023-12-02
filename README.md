# HomeLab Setup
<p align="left">
Neste repositório armazenei vários scripts para fazer a instalação
de um servidor local com serviços em containers.
</p>

## Scripts para:
> - Instalação de pacotes iniciais para Linux Debian
> - Instalação do Docker, Docker Compose e Portainer
> - Instalação do Ansible e script de adição de hosts rapidamente

### Ordem de execução
1. Suba um servidor Linux Debian.
    - Instale o pacote git e faça o download deste repositório.
        - git clone https://github.com/BrunoOcana/HomeLab.git
    - Vá para o diretório Master-Linux.
        - Execute o script de configuração básica de instalação.
        - Execute o script de instalação base do docker.
2. Mude para o diretório docker.
    - Para subir containers de gerenciamento, vá para o diretório portainer-semaphore.
        - Execute "docker-compose up -d".
    - Para subir os websites de teste, vá para o diretório website.
        - Execute o script para download do sitebike, feito por um colaborador do Senai.
        - Execute "docker-compose up -d".
3. Vamos para o diretório ansible.
    - Faça a configuração padrão que o script de instalação básica pede (usuário ansible).
    - Rode o script de configuração básica.
    - Use o python3 para executar o script de setup de acesso dos clientes ansible.
4. Se tudo der certo, você deve ter um servidor preparado para controlar seu laboratório!