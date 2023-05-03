# https://developer.hashicorp.com/terraform/language/settings/backends/s3
terraform {
  backend "s3" {
    bucket = "linuxwindfy"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
