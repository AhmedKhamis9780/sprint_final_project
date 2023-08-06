output "subnet_id1" {
  value = aws_subnet.private[*].id
}
# output "subnet_id2" {
#   value = aws_subnet.private[1].id
# }