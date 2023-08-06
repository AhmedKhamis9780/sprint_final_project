output "subnet_id1" {
  value = aws_subnet.public[*].id
}
# output "subnet_id2" {
#   value = aws_subnet.public[1].id
# }