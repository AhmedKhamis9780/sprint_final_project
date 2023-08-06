output "endpoint" {
  value = aws_eks_cluster.sprint.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.sprint.certificate_authority[0].data
}
output "public_ec2_ips" {
  value = module.pub_ec2.public_ec2_ips
}
output "load_balancer_DNS" {
  value = module.public_id.id_DNS
}
output "ecr_url_repo" {
  value = aws_ecr_repository.sprint.repository_url
}