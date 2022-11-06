resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  user_data =  var.user_data 
  #key_name = var.ssh_key_name
  root_block_device {
      volume_type = var.root_volume_type
      volume_size = var.root_volume_size
  }
  ebs_block_device {
      device_name = "/dev/sdh"
      volume_size = var.ebs_volume_size
      volume_type = var.ebs_volume_type
  }
 
}

#resource "aws_key_pair" "challenge" {
  #key_name   = var.key_name
  #public_key = file("${path.module}/public_key")
