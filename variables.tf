variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}
variable "vpc_id" {
  description = "The VPC ID to attach the Route53 Resolver to"
  type        = string
}
variable "cidr_blocks" {
  description = "The CIDR block range of the VPC that will be allowed to access the Route53 Resolver"
  type        = string
}
variable "subnets" {
  description = "A list of subnets to create Route53 Resolver endpoints in"
  type        = list
}
variable "tld" {
  description = "The top level domain to forward DNS for"
  type        = string
}
variable "private_dns" {
  description = "A list of corporate DNS server IP addresses"
  type        = list
}