output "vm_public_ip_address" {
  value = "${azurerm_public_ip.myterraformpublicip.*.ip_address}"
}