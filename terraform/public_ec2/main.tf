# Create EC2 Instance
resource "aws_iam_role" "ec2" {
  name = "ec2_jenkins"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "admin_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.ec2.name
}

resource "aws_iam_instance_profile" "ec2-profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2.name
}

resource "aws_key_pair" "tf-key-pair" {
key_name = "tf-key-pair"
public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}
resource "local_file" "tf-key" {
content  = tls_private_key.rsa.private_key_pem
filename = "tf-key-pair"
}

resource "aws_instance" "public" {
  count =length(var.subnet)
  ami                    = var.AMIS
  instance_type          = var.INSTANCE_Type
  subnet_id              = var.subnet[count.index]
  vpc_security_group_ids = [var.sg]
  source_dest_check      = false
  associate_public_ip_address = true
  key_name = "tf-key-pair"
  iam_instance_profile = aws_iam_instance_profile.ec2-profile.name
  root_block_device {
    volume_size = 30 
    volume_type = "gp3"
  }
  
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > jenkins-ip.txt"
  }
  tags = {
    Name = var.name
  }

}