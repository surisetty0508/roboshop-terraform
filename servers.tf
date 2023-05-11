data "aws_ami" "centos" {
  owners      = ["973714476881"]
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
}
data "aws_security_group" "allow-all" {
  name = "allow-all"
}


output "ami" {
  value = data.aws_ami.centos.image_id
}

variable "instance_type" {
  default ="t3.small"
}

variable "components" {
  default = {
    frontend = {
      name          = "frontend"
      instance_type = "t3.small"
    }
    mongodb = {
      name          = "mongodb"
      instance_type = "t3.small"
    }
    catalogue = {
      name          = "catalogue"
      instance_type = "t3.small"
    }
    user = {
      name          = "user"
      instance_type = "t3.small"
    }
    rabbitmq = {
      name          = "rabbitmq"
      instance_type = "t3.small"
    }
    cart = {
      name          = "cart"
      instance_type = "t3.small"
    }
    redis = {
      name          = "redis"
      instance_type = "t3.small"
    }
    mysql = {
      name          = "mysql"
      instance_type = "t3.small"
    }
    payment = {
      name          = "payment"
      instance_type = "t3.small"
    }
    dispatch = {
      name          = "dispatch"
      instance_type = "t3.small"
    }
  }
}
resource "aws_instance" "instance" {
  for_each               = var.components
  ami                    = data.aws_ami.centos.image_id
  instance_type          = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_route53_record" "records" {
  for_each= var.components
  zone_id = "Z07468143H8ZATXPWON7O"
  name    = "${each.value["name"]}-dev.devops72.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance[each.value["name"]].private_ip]
}

#output "shipping" {
#  value = aws_instance.shipping.public_ip
#}
#
#resource "aws_instance" "redis" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "redis"
#  }
#}
#
#resource "aws_instance" "rabbitmq" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "rabbitmq"
#  }
#}
#
#resource "aws_instance" "payment" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#
#  tags = {
#    Name = "payment"
#  }
#}
#
#resource "aws_instance" "frontend" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#
#  tags = {
#    Name = "frontend"
#  }
#}
#
#resource "aws_instance" "mysql" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#
#  tags = {
#    Name = "mysql"
#  }
#}
#resource "aws_instance" "mongodb" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#
#  tags = {
#    Name = "mongodb"
#  }
#}
#
#resource "aws_instance" "dispatch" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "dispatch"
#  }
#}
#
#resource "aws_instance" "catalogue" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "catalogue"
#  }
#}
#
#resource "aws_instance" "cart" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "cart"
#  }
#}
#
#resource "aws_instance" "user" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#  tags = {
#    Name = "user"
#  }
#}


