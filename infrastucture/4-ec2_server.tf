resource "aws_key_pair" "ansible_ec2" {
  key_name   = "ansible_ec2"
  public_key = file("~/.ssh/ansible.pub")

}

resource "aws_instance" "load_balancer_node" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_1.id
  vpc_security_group_ids              = [aws_security_group.load_balancer_server.id]  
  associate_public_ip_address = true

#   source_dest_check = false # for calico



  key_name = "ansible_ec2"
#   iam_instance_profile = 

  tags = {
    Name = "master_node"
  }
}


resource "aws_instance" "server_1" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_1.id
  vpc_security_group_ids              = [aws_security_group.server_node_sg.id] 
  associate_public_ip_address = true

  source_dest_check = false # for calico

  key_name = "ansible_ec2"
#   iam_instance_profile = 

  tags = {
    Name = "server_1"
  }
}

resource "aws_instance" "server_2" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_2.id
  vpc_security_group_ids              = [aws_security_group.server_node_sg.id] 
  associate_public_ip_address = true

#   source_dest_check = false # for calico


  key_name = "ansible_ec2"
#   iam_instance_profile = 

  tags = {
    Name = "server_2"
  }
}




output "load_balancer_node" {
  value = aws_instance.load_balancer_node.public_ip
}

output "server_1" {
  value = aws_instance.server_1.public_ip
}

output "server_2" {
  value = aws_instance.server_2.public_ip
}

output "server_1_private" {
  value = aws_instance.server_1.private_ip
}

output "server_2_private" {
  value = aws_instance.server_2.private_ip
}
