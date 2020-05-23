resource "aws_security_group" "this" {
  description = "Route53 Resolver"
  name        = format("hybrid-dns-resolver-%s%s", var.name)
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_route53_resolver_endpoint" "this" {
  name      = format("internal-%s", var.name)
  direction = "OUTBOUND"

  security_group_ids = [
    aws_security_group.this.id
  ]

  dynamic "ip_address" {
    for_each = var.subnets
    content {
      subnet_id = ip_address.value
    }
  }
}

resource "aws_route53_resolver_rule" "this" {
  domain_name          = var.tld
  name                 = "corporate"
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.this.id

  dynamic "target_ip" {
    for_each = var.private_dns
    content {
      subnet_id = target_ip.value
    }
  }
}

resource "aws_route53_resolver_rule_association" "this" {
  resolver_rule_id = aws_route53_resolver_rule.this.id
  vpc_id           = var.vpc_id
}