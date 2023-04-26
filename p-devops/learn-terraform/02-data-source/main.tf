data "aws_security_group" "selected" {
    name="allows_tls"
}

output "security_group_id" {
    value = data.aws_security_group.selected
}