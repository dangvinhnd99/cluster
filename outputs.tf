output "security_nodes_id" {
  value = aws_security_group.k8_nodes.id
}
output "security_worker_id" {
  value = aws_security_group.k8_workers.id
}
output "security_k8_masters_id" {
  value = aws_security_group.k8_masters.id
}

