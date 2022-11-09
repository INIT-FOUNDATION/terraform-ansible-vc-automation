resource "random_integer" "subnet_index" {
  min = 0
  max = 2
}

resource "aws_instance" "vc" {  

  for_each = toset(split(",", join(",",range(1,var.servers_count+1))))
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  monitoring             = false
  vpc_security_group_ids = [aws_security_group.vc[each.key].id]
  subnet_id              = var.subnet_ids[random_integer.subnet_index.result]
  iam_instance_profile   = var.iam_instance_profile
  user_data              = <<-EOT
  #!/bin/bash
  sudo apt-get -y update;
  sudo apt-get install -y certbot;
  EOT
 
  root_block_device {
      delete_on_termination = true
      volume_type = "gp3"
      volume_size = var.root_volume_size
      iops        = var.root_volume_iops
      throughput  = var.root_volume_throughput
      encrypted   = true
      kms_key_id  = var.root_volume_kms_key_arn
  }
  
  tags = {
    Name = "${var.app_name}-vc-${each.key}-${var.env}"
    domain = "vc${each.key}${random_string.priority.result}.${var.zone_name}"
    vc_server = true
    Stack = "PROD"
  }
}


resource "random_string" "priority" {
  length = 5
  special = false
  lower = true
  upper = false
  numeric = false
}

resource "local_file" "hosts_cfg" {
  for_each = toset(split(",", join(",",range(1,var.servers_count+1))))
  content = templatefile("ansible/templates/hosts.tpl",
    {
      vc_servers = [for vc_server in aws_instance.vc : {
    				instance_id = vc_server.id, 
    				domain = vc_server.tags_all.domain,
				env = lower(vc_server.tags_all.Stack)
										
      }]
    }
  )
  filename = "ansible/inventory/hosts.cfg"
}
