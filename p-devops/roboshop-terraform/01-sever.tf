data "aws_ami" "centos" {
  owners           = ["521045274894"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
}

data "aws_security_group" "selected" {
    name="allows_tls"
}

# variable "instance_type" {
#   default = "t2.micro"
# }

# variable "components" {
#   default = ["frontent", "mongodb","catalogue"]
# }

resource "aws_instance" "frontend" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  tags = {
    Name = var.components[count.index]
  }
}

resource "aws_route53_record" "frontend" {
  zone_id = "Z03986262CQPCHNJNZM9L"
  name    = "frontend-dev.ramakrishna.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.frontend.private_ip]
}

# resource "aws_instance" "mongodb" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [data.aws_security_group.selected.id]
#   tags = {
#     Name = "mongodb"
#   }
# }

# resource "aws_route53_record" "mongodb" {
#   zone_id = "Z03986262CQPCHNJNZM9L"
#   name    = "mongodb-dev.ramakrishna.online"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.mongodb.private_ip]
# }

# resource "aws_instance" "catalogue" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [data.aws_security_group.selected.id]
#   tags = {
#     Name = "catalogue"
#   }
# }

# resource "aws_route53_record" "catalogue" {
#   zone_id = "Z03986262CQPCHNJNZM9L"
#   name    = "catalogue-dev.ramakrishna.online"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.catalogue.private_ip]
# }

# resource "aws_instance" "redis" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [data.aws_security_group.selected.id]
#   tags = {
#     Name = "redis"
#   }
# }

# resource "aws_route53_record" "redis" {
#   zone_id = "Z03986262CQPCHNJNZM9L"
#   name    = "redis-dev.ramakrishna.online"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.redis.private_ip]
# }

# resource "aws_instance" "user" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#   vpc_security_group_ids =  [ data.aws_security_group.selected.id ]
#   tags = {
#     Name = "user"
#   }
# }

# resource "aws_route53_record" "user" {
#   zone_id = "Z03986262CQPCHNJNZM9L"
#   name    = "user-dev.ramakrishna.online"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.user.private_ip]
# }

# resource "aws_instance" "cart" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [data.aws_security_group.selected.id]
#   tags = {
#     Name = "cart"
#   }
# }

# resource "aws_route53_record" "cart" {
#   zone_id = "Z03986262CQPCHNJNZM9L"
#   name    = "cart-dev.ramakrishna.online"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.cart.private_ip]
# }

# resource "aws_instance" "mysql" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [data.aws_security_group.selected.id]
#   tags = {
#     Name = "mysql"
#   }
# }

# resource "aws_route53_record" "mysql" {
#   zone_id = "Z03986262CQPCHNJNZM9L"
#   name    = "mysql-dev.ramakrishna.online"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.mysql.private_ip]
# }

# resource "aws_instance" "shipping" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [data.aws_security_group.selected.id]
#   tags = {
#     Name = "shipping"
#   }
# }

# resource "aws_route53_record" "shipping" {
#   zone_id = "Z03986262CQPCHNJNZM9L"
#   name    = "shipping-dev.ramakrishna.online"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.shipping.private_ip]
# }

# resource "aws_instance" "rabbitmq" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [data.aws_security_group.selected.id]
#   tags = {
#     Name = "rabbitmq"
#   }
# }

# resource "aws_route53_record" "rabbitmq" {
#   zone_id = "Z03986262CQPCHNJNZM9L"
#   name    = "rabbitmq-dev.rdevopsb72.online"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.rabbitmq.private_ip]
# }

# resource "aws_instance" "payment" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [data.aws_security_group.selected.id]
#   tags = {
#     Name = "payment"
#   }
# }

# resource "aws_route53_record" "payment" {
#   zone_id = "Z03986262CQPCHNJNZM9L"
#   name    = "payment-dev.ramakrishna.online"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.payment.private_ip]
# }
