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


resource "aws_instance" "public" {
  count =length(var.subnet)
  ami                    = var.AMIS
  instance_type          = var.INSTANCE_Type
  subnet_id              = var.subnet[count.index]
  vpc_security_group_ids = [var.sg]
  source_dest_check      = false
  associate_public_ip_address = true
  key_name = var.KEY
  iam_instance_profile = aws_iam_instance_profile.ec2-profile.name
  root_block_device {
    volume_size = 30 
    volume_type = "gp3"
  }
  
  tags = {
    Name = var.name
  }

}