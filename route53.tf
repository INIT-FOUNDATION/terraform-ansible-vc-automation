resource "aws_route53_record" "vc" {
  for_each = toset(split(",", join(",",range(1,var.servers_count+1))))
  zone_id = var.zone_id
  
  name    = aws_instance.vc[each.key].tags_all.domain
  type    = "A"
  ttl     = 300
  records = [aws_eip.vc[each.key].public_ip]

  provisioner "local-exec" {
    command = "ansible-playbook -i ansible/inventory/hosts.cfg ansible/vc_install.yaml  -vvv"
  }

}
