output "private_ec2_id1" {
  value = aws_instance.private[*].id
}
# output "private_ec2_id2" {
#   value = aws_instance.private[1].id
# }