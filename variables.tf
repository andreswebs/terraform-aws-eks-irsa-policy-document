variable "k8s_sa_name" {
  type        = string
  default     = "default"
  description = "Name of the Kubernetes service account"
}

variable "k8s_sa_namespace" {
  type        = string
  default     = "default"
  description = "Namespace of the Kubernetes namespace"
}

variable "cluster_oidc_provider" {
  type        = string
  description = "OpenID Connect (OIDC) Identity Provider associated with the Kubernetes cluster"
}
