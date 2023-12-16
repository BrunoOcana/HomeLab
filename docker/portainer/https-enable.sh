# Instalando ou atualizando o openssl
apt update
apt install openssl

# Gerando o certificado na pasta "certs"
openssl genrsa -out ./certs/portainer.key 2048
openssl req -new -key portainer.key -out ./certs/portainer.csr
openssl x509 -req -days 365 -in ./certs/portainer.csr -signkey ./certs/portainer.key -out ./certs/portainer.crt

# Criando o volume no docker
docker volume create portainer_data