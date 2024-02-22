data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "boundary" {
  key_name   = "${var.tag}-${random_pet.test.id}"
  public_key = var.pub_ssh_key

  tags = local.tags
}

resource "aws_security_group" "worker" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.tag}-worker-${random_pet.test.id}"
  }
}

resource "aws_security_group_rule" "allow_ingress_controller" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.worker.id
}

resource "aws_security_group_rule" "allow_egress_controller" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.worker.id
}

# Example resource for connecting to through boundary over SSH
# resource "aws_instance" "target" {
#   count                         = var.num_targets
#   ami                           = data.aws_ami.ubuntu.id
#   instance_type                 = "t3.micro"
#   subnet_id                     = aws_subnet.public.*.id[count.index]
#   key_name                      = aws_key_pair.boundary.key_name
#   vpc_security_group_ids        = [aws_security_group.worker.id]
#   associate_public_ip_address   = true
#   tags = {
#     Name = "${var.tag}-target-${random_pet.test.id}-${count.index}"
#   }
#   user_data = <<EOF
# #!/bin/bash
# sudo bash -c "echo ${data.terraform_remote_state.hcp_vault_manage.outputs.vault_boundary_ssh_ca} > /etc/ssh/ca-key.pub" \
# sudo chown 1000:1000 /etc/ssh/ca-key.pub
# sudo chmod 644 /etc/ssh/ca-key.pub
# sudo bash -c "echo TrustedUserCAKeys /etc/ssh/ca-key.pub >> /etc/ssh/sshd_config"
# sudo systemctl restart sshd.service
#   EOF
# }

# resource "aws_instance" "worker" {
#   ami                           = data.aws_ami.ubuntu.id
#   instance_type                 = "t3.micro"
#   subnet_id                     = aws_subnet.public.*.id[1]
#   key_name                      = aws_key_pair.boundary.key_name
#   vpc_security_group_ids        = [aws_security_group.worker.id]
#   associate_public_ip_address   = true
#   tags = {
#     Name = "${var.tag}-target-${random_pet.test.id}-worker"
#   }
# }