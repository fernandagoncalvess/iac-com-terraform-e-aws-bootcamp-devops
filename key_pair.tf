# Gera uma chave privada RSA de 4096 bits
resource "tls_private_key" "rsa_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

# Cria o Key Pair na AWS usando a chave pública gerada
resource "aws_key_pair" "ec2_key_pair" {
    key_name   = "ec2-instance-key" # Nome do key pair na AWS
    public_key = tls_private_key.rsa_key.public_key_openssh
}

# Salva a chave privada em um arquivo local
resource "local_file" "private_key_pem" {
    content  = tls_private_key.rsa_key.private_key_pem
    filename = "${path.module}/ec2-instance-key.pem"

    # Define as permissões do arquivo para que apenas o proprietário possa ler e escrever
    file_permission = "0600"
}
