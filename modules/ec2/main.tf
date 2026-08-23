#########################################################
# Generic EC2 Instance
#########################################################

resource "aws_instance" "this" {

  ami = var.ami_id

  instance_type = var.instance_type

  subnet_id = var.subnet_id

  vpc_security_group_ids = var.security_group_ids

  iam_instance_profile = var.instance_profile_name

  user_data = templatefile(
    "${path.module}/user-data.sh.tpl",
    {}
  )

  associate_public_ip_address = true

  root_block_device {

    volume_size = var.root_volume_size

    volume_type = "gp3"

    encrypted = true

    delete_on_termination = true
  }

  tags = merge(
    var.common_tags,
    {
      Name = var.instance_name
    }
  )
}

