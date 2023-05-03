data "aws_ami" "centos" {
  owners           = ["521045274894"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
}

data "aws_security_group" "selected" {
    name="allows_tls"
}

variable "components" {
  default = {
    frontend = {
      name = "frontend"
      instance_type = "t2.micro"
    }
    mangodb = {
      name = "mangodb"
      instance_type = "t2.micro"
    }
    catalogue = {
      name = "catalogue"
      instance_type = "t2.micro"
    }
    redis = {
      name = "redis"
      instance_type = "t2.micro"
    }
    user = {
      name = "user"
      instance_type = "t2.micro"
    }
    cart = {
      name = "cart"
      instance_type = "t2.micro"
    }
    mysql = {
      name = "mysql"
      instance_type = "t2.micro"
    }
    shipping = {
      name = "shipping"
      instance_type = "t2.micro"
    }
    rabbitmq = {
      name = "rabbitmq"
      instance_type = "t2.medium"
    }
    payment = {
      name = "payment"
      instance_type = "t2.micro"
    }
    dispatch = {
      name = "dispatch"
      instance_type = "t2.micro"
    }
  }
}

resource "aws_instance" "instance" {
  #count = length(var.components)
  for_each = var.components
  ami           = data.aws_ami.centos.image_id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  tags = {
    Name = var.value["name"]
  }
}

resource "aws_route53_record" "records" {
  for_each = var.components
  zone_id = "Z03986262CQPCHNJNZM9L"
  name    = "${each.value["name"]}-dev.ramakrishna.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance[each.value["name"]].private_ip]
}

