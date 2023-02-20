
# Create Ubuntu master Instance 
resource "aws_instance" "worker_node1" {
  ami                         = var.ami
  instance_type               = var.type
  key_name                    = var.keyname
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_nodes_id, var.security_worker_id]
  associate_public_ip_address = true
  //user_data                   = file("/home/vinh/Documents/transitGW-terraform/VPCA/VPC1_userdata_web.sh")
  tags = {
    Name = "worker_node1_anhdo_vinh"
  }
}
