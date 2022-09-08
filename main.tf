provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_pass}"
  vsphere_server = "${var.vsphere_server1}"
 
  allow_unverified_ssl = true
}
 
data "vsphere_datacenter" "dc" {
   name = "${var.vsphere_dc1}"
}

data "vsphere_datastore" "datastore_vm" {
   name          = "Dick-SSD"
   datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "datastore_iso" {
   name          = "datastore1"
   datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "vm_network" {
   name          = "VM Network"
   datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "Lab 1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_host" "varya" {
   name = "192.168.15.34"
   datacenter_id = "${data.vsphere_datacenter.dc.id}" 
}

data "vsphere_virtual_machine" "template" {
  name          = "cml2-patched"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}