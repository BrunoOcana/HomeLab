# Instalando ou atualizando o openssl
apt update
apt install openssl
mkdir certs

# Gerando o certificado na pasta "certs"
openssl genrsa -out ./certs/portainer.key 2048
openssl req -new -key ./certs/portainer.key -out ./certs/portainer.csr
openssl x509 -req -days 365 -in ./certs/portainer.csr -signkey ./certs/portainer.key -out ./certs/portainer.crt