output "public_ec2_id1" {
  value = aws_instance.public[*].id
}
output "public_ec2_ips" {
  value = aws_instance.public[*].public_ip
}