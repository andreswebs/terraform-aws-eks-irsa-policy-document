# terraform-aws-eks-irsa-policy-document

[//]: # (BEGIN_TF_DOCS)
Creates a trust policy for an IAM role that can be assumed by
a Kubernetes service account.

The cluster OIDC provider value can be found with the
command:

```sh
aws eks describe-cluster \
  --name "${CLUSTER_NAME}" \
  --query "cluster.identity.oidc.issuer" \
  --output text | sed -e "s/^https:\\/\\///"
```

## Usage

Example:

```hcl
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
```



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_oidc_provider"></a> [cluster\_oidc\_provider](#input\_cluster\_oidc\_provider) | OpenID Connect (OIDC) Identity Provider associated with the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_k8s_sa_name"></a> [k8s\_sa\_name](#input\_k8s\_sa\_name) | Name of the Kubernetes service account | `string` | `"default"` | no |
| <a name="input_k8s_sa_namespace"></a> [k8s\_sa\_namespace](#input\_k8s\_sa\_namespace) | Namespace of the Kubernetes namespace | `string` | `"default"` | no |

## Modules

No modules.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_json"></a> [json](#output\_json) | The IAM policy JSON contents |
| <a name="output_k8s_sa_name"></a> [k8s\_sa\_name](#output\_k8s\_sa\_name) | Name of the Kubernetes service account |
| <a name="output_k8s_sa_namespace"></a> [k8s\_sa\_namespace](#output\_k8s\_sa\_namespace) | Namespace of the Kubernetes namespace |
| <a name="output_oidc_provider"></a> [oidc\_provider](#output\_oidc\_provider) | Cluster OIDC provider |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.50.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.50.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

[//]: # (END_TF_DOCS)

## Authors

**Andre Silva** - [@andreswebs](https://github.com/andreswebs)

## License

This project is licensed under the [Unlicense](UNLICENSE.md).
