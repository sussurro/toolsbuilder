
locals {
  dc-userdata = <<EOF
<powershell>
  $admin = [adsi]("WinNT://./administrator, user")
  $admin.psbase.invoke("SetPassword", "${var.dc_password}")
</powershell>

EOF
}


resource "aws_instance" "tools" {
  ami           = data.aws_ami.tools_image.id
  instance_type = "t2.large"
  key_name = var.key_name

  subnet_id = aws_default_subnet.default_subnet.id

  user_data_base64 = base64encode(local.dc-userdata)
  vpc_security_group_ids = [aws_security_group.ghh_windows.id]
  associate_public_ip_address = true

  root_block_device {
        volume_size = 200 
  }



  tags = {
    Name = "tools_builder"
  }
}
