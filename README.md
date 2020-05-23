# Terraform Module for AWS Hybrid DNS

This Terraform module creates a Route53 Resolver to enable Hybrid DNS resolution in a corporate VPC.

**Requires**:
- AWS Provider
- Terraform 0.12

## Resources Created

Resources Created:
- Security Group
- Route53 Resolver Endpoint
- Route53 Resolver Rule

**Estimated Operating Cost**: $ 182.50 / month

- $ 91.25 / subnet for Route53 Resolver ENI (minimum of two)

## Example

```hcl-terraform
module "hyrid-dns" {
  source            = "lorenzoaiello/hyrid-dns/aws"
  version           = "x.y.z"
  name              = "myResolverName"
  vpc_id            = "vpc-abc1234"
  cidr_blocks       = ["100.64.0.0/10"]
  subnets           = module.vpc.private_subnets // minimum of two
  tld               = "mydomain.com"
  private_dns       = ["10.0.0.1", "10.0.0.2"]
}

```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr\_blocks | The CIDR block range of the VPC that will be allowed to access the Route53 Resolver | `string` | n/a | yes |
| name | Name to be used on all the resources as identifier | `string` | n/a | yes |
| private\_dns | A list of corporate DNS server IP addresses | `list` | n/a | yes |
| subnets | A list of subnets to create Route53 Resolver endpoints in | `list` | n/a | yes |
| tld | The top level domain to forward DNS for | `string` | n/a | yes |
| vpc\_id | The VPC ID to attach the Route53 Resolver to | `string` | n/a | yes |

## Outputs

No output.

