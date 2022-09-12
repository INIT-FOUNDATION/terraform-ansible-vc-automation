resource "aws_security_group" "vc" {
  for_each = toset(split(",", join(",",range(1,var.servers_count+1))))
  description = "Security Group for ${var.app_name} ${each.key}"
  name = "${var.app_name}-vc-${each.key}-${var.env}"

  vpc_id      = var.vpc_id
  
  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "UDP"
    from_port        = 16384
    to_port          = 32768
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
   
  tags = {
    Name = "${var.app_name}-vc-${each.key}-${var.env}"
    vc_server = true
    Stack = "PROD"
  }
  
}
