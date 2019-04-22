output "DNS Servidor Web" {
  value = "${aws_instance.web-demo.*.public_dns}"
}

output "IP Publico Servidor Web" {
  value = "${aws_instance.web-demo.*.public_ip}"
}

/* output "ELB DNS" {
  value = "${aws_elb.web.dns_name}"
}
 */

