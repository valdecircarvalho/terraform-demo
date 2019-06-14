provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

#ha-datacenter
data "vsphere_datacenter" "dc" {
  name = "ha-datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
  name                       = "terraform-test-${count.index + 1}"
  count                      = 3
  datastore_id               = "${data.vsphere_datastore.datastore.id}"
  wait_for_guest_net_timeout = 0
  num_cpus                   = 1
  memory                     = 1024
  guest_id                   = "other3xLinux64Guest"
  resource_pool_id           = "${data.vsphere_resource_pool.pool.id}"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label = "disk0"
    size  = 1
  }

  cdrom {
    datastore_id = "${data.vsphere_datastore.datastore.id}"
    path         = "iso/alpine-extended-3.9.3-x86_64.iso"
  }
}
