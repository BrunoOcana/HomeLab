import os
import paramiko
inputing = True
hosts = {}

# Adicionar o grupo Python no documento /etc/ansible/hosts

question = str(input("Você já configurou o usuário 'ansible' nos clientes?\n(s/n): "))
if question.lower() != "s":
    exit("Configure o usuário com 'adduser ansible' e 'adduser ansible sudo'.\nVolte para \
    este script quando terminar este passo. A senha deve ser Senai@134.")
else:
    with open('/etc/ansible/hosts', 'a') as file:
        file.write("\n[python]")

# =========== Input de dados ============== #

while inputing:
   # Inserir um host?
    repeat = input("\nDeseja adicionar um host (s/n)?\nOu deixe em branco para terminar: ")
    if repeat.lower() == "n" or repeat == "" or repeat == None:
        inputing == False; break
    elif repeat.lower() == "s":
        inputing == True
    else: print("Não entendi sua resposta."); continue

    # Input e testando erros
    hostName = input("Informe o nome do host: ")
    hostIp = input("Informe o IP do host: ")
    if len(hostIp) > 15 or len(hostIp) < 7 or type(hostName) != str or type(hostIp) != str:
        print("O nome ou IP não parece correto..."); continue 
    hosts[hostName] = hostIp

# ========================================== #

# Adicionar o host no documento /etc/ansible/hosts
for k in hosts:
    with open('/etc/ansible/hosts', 'a') as file:
        file.write(k+" ansible_host="+hosts[k])

# Adicionando as variáveis ao grupo python
with open('/etc/ansible/hosts', 'a') as file:
        file.write("""[python:vars]
        \nansible_python_interpreter=/usr/bin/python3
        \nansible_ssh_user=root
        \nansible_ssh_private_key_file=/root/.ssh/id_rsa""")

# Acessando os hosts e executando um comando simples
for i in hosts:
    command2 = "sudo echo PermitRootLogin yes >> /etc/ssh/sshd_config"
    command = "sudo hostname && hostname -I"

    host = hosts[i]
    username = "ansible"  # Recomendado ter um usuario só para o ansible
    password = "Senai@134"

    client = paramiko.client.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(host, username=username, password=password)
    _stdin, _stdout,_stderr = client.exec_command(command)
    print(_stdout.read().decode())
    _stdin, _stdout,_stderr = client.exec_command(command2)
    print(_stdout.read().decode())
    client.close()

# Colocando a chave de SSH nos hosts
erros = []

for k in hosts:
    try:
        os.system("ssh-copy-id -i /root/.ssh/id_rsa.pub root@"+hosts[k])
    except:
        print("Não foi possível enviar a chave pública para o host ",k)
        erros.append(hosts[k])

# Mostrando quais hosts falharam ao tentarem receber a chave SSH
if len(erros) > 0:
    print(erros)
