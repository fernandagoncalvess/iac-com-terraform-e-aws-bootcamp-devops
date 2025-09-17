#!/bin/bash
# Aguarda a inicialização completa da rede
sleep 10

# Atualiza pacotes
yum update -y

# Instala o Ansible (no Amazon Linux 2, usa-se o amazon-linux-extras)
amazon-linux-extras install -y ansible2

# Instala o Git para clonar o playbook
yum install -y git wget

# Baixa o playbook
mkdir -p /home/ec2-user/ansible-config
wget -c https://gitlab.com/avanti-dvp/iac-com-terraform-e-aws/-/raw/main/playbook.yaml -O /home/ec2-user/ansible-config/playbook.yaml
chown ec2-user:ec2-user /home/ec2-user/ansible-config/playbook.yaml

# Executa o playbook Ansible localmente
ansible-playbook /home/ec2-user/ansible-config/playbook.yaml > /var/log/ansible-playbook.log 2>&1