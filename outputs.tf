output "json" {
  value       = data.aws_iam_policy_document.this.json
  description = "The IAM policy JSON contents"
}

output "k8s_sa_name" {
  value       = var.k8s_sa_name
  description = "Name of the Kubernetes service account"
}

output "k8s_sa_namespace" {
  value       = var.k8s_sa_namespace
  description = "Namespace of the Kubernetes service account"
}

output "oidc_provider" {
  value       = local.oidc_provider
  description = "Cluster OIDC provider"
}
