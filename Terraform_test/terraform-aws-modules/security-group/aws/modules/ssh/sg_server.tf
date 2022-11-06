resource "aws_security_group" "ssh" {
  name        = var.name
  description = "Allow SSh"
  vpc_id      = var.vpc

  ingress {
    description      = "Allow SSH Traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.ingress_cidr_blocks
   
  }
}
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.ingress_cidr_blocks
   
}