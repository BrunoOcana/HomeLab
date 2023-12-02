# Atualizando e baixando
apt update
apt install ansible pip python3 python3-pip python3-paramiko -y

# Setup básico dos files
mkdir -p /etc/ansible/playbooks
touch /etc/ansible/hosts

# Achando e jogando IP no documento hosts
# ip -4 address show ens33 | grep inet | awk '{print $2}'
echo "[default]" >> /etc/ansible/hosts
echo "ansible-server" `hostname -I | awk '{print $1}'` >> /etc/ansible/hosts

cat <<EOF>> /etc/ansible/hosts

[default:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_user=root
ansible_ssh_private_key_file=/root/.ssh/id_rsa
EOF