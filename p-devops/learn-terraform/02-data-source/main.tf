# https://registry.terraform.io/providers/hashicorp/aws/2.60.0/docs/data-sources/security_group

data "aws_security_group" "selected" {
    name="allows_tls"
}

output "security_group_id" {
    value = data.aws_security_group.selected
}