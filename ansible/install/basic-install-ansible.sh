# Atualizando e baixando
apt update
apt install ansible pip python3 python3-pip -y
pip install paramiko:latest -y

# Setup básico dos files
mkdir -p /etc/ansible/playbooks
touch /etc/ansible/hosts

# Achando e jogando IP no documento hosts
# ip -4 address show ens33 | grep inet | awk '{print $2}'
echo "[default]" >> /etc/ansible/hosts
echo "ansible_server `hostname -I`" >> /etc/ansible/hosts

cat <<EOF>> /etc/ansible/hosts

[default:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_user=root
ansible_ssh_private_key_file=/root/.ssh/id_rsa
EOF