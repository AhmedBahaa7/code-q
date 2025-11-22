resource "aws_instance" "node" {
  for_each = var.nodes

  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id
  key_name               = each.value.key_name
  vpc_security_group_ids = each.value.security_group_ids

  associate_public_ip_address = each.value.associate_public_ip

  root_block_device {
    volume_size = each.value.root_volume_size
  }

  tags = {
    Name = each.key
  }
}
