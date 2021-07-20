module "k8s_assume_role_policy" {
  source                = "github.com/andreswebs/terraform-aws-eks-irsa-policy-document"
  k8s_sa_name           = "hyperapp"
  k8s_sa_namespace      = "frontend"
  cluster_oidc_provider = var.cluster_oidc_provider
}

resource "aws_iam_role" "hyperapp" {
  name               = "hyperapp"
  assume_role_policy = module.k8s_assume_role_policy.json
}