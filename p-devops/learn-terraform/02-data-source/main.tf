# https://registry.terraform.io/providers/hashicorp/aws/2.60.0/docs/data-sources/security_group

# data "aws_security_group" "selected" {
#     name="allows_tls"
# }

# output "security_group_id" {
#     value = data.aws_security_group.selected
# }

data "aws_security_groups" "test" {}

data "aws_security_group" "single" {
    count  = length(data.aws_security_groups.test.ids)
    id = data.aws_security_group.test.ids[count.index]
}

output "all_sg" {
    value = data.aws_security_groups.test
}

output "single" {
    value = data.aws_security_group.test
}