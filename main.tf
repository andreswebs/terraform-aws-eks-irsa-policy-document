/**
* # terraform-aws-eks-irsa-policy-document
*
* Creates a trust policy for an IAM role that can be assumed by
* a Kubernetes service account.
*
* The cluster OIDC provider value can be found with the
* command:
*
* ```sh
* aws eks describe-cluster \
*   --name "${CLUSTER_NAME}" \
*   --query "cluster.identity.oidc.issuer" \
*   --output text | sed -e "s/^https:\\/\\///"
* ```
*
*/

terraform {
  required_version = ">= 1.0.0"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.50.0"
    }

  }
}

locals {
  oidc_provider = replace(var.cluster_oidc_provider, "https://", "")
}

data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this" {

  statement {

    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_provider}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider}:sub"
      values   = ["system:serviceaccount:${var.k8s_sa_namespace}:${var.k8s_sa_name}"]
    }

  }
}
