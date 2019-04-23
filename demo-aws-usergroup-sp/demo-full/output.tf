output "Endereço DNS do Servidor Web" {
  value = "${aws_instance.web-demo.*.public_dns}"
}

output "IP Publico Servidor Web" {
  value = "${aws_instance.web-demo.*.public_ip}"
}

output "Endereço DNS do ELB " {
  value = "${aws_elb.web.dns_name}"
}


