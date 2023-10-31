data "aws_route53_zone" "selected" {
  name = "papavonning.com."
}

resource "aws_route53_record" "test" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "test.papavonning.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.load_balancer_node.public_ip]
  
# depends_on = [ aws_instance.aws_instance.load_balancer_node ]
}