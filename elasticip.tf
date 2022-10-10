resource "aws_eip" "vc" {
  for_each = toset(split(",", join(",",range(1,var.servers_count+1))))
  instance = aws_instance.vc[each.key].id
  vpc      = true
  tags = {
    Name = "${var.app_name}-vc-${each.key}-${var.env}"
    Stack = "PROD"
  }
}
