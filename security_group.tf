# 1. Security Group para liberar a porta 80 (HTTP) para qualquer origem
resource "aws_security_group" "http_sg" {
    name        = "allow-http-sg"
    description = "Allow HTTP inbound traffic"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow-http"
    }
}

# 2. Security Group para liberar a porta 22 (SSH) para um IP específico
resource "aws_security_group" "ssh_sg" {
    name        = "allow-ssh-sg"
    description = "Allow SSH inbound traffic from a specific IP"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.meu_ip_publico]
    }

    tags = {
        Name = "allow-ssh"
    }
}

# 3. Security Group para liberar todo o tráfego de saída (Egress)
resource "aws_security_group" "egress_all_sg" {
    name        = "allow-all-egress-sg"
    description = "Allow all outbound traffic"

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # "-1" representa todos os protocolos
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow-all-egress"
    }
}
