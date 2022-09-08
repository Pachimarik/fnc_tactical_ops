resource "vsphere_virtual_machine" "vm" {
  name               = "national team competitor ${count.index + 1}"
  count              = "${var.instance_count}"

  resource_pool_id   = "${data.vsphere_resource_pool.pool.id}"
  datastore_id       = "${data.vsphere_datastore.datastore_vm.id}"

  num_cpus           = "${var.instance_cpu}"
  memory             = "${var.instance_ram}"
  guest_id           = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type          = "${data.vsphere_virtual_machine.template.scsi_type}"

  firmware           = "efi"
  nested_hv_enabled  = "${data.vsphere_virtual_machine.template.nested_hv_enabled}"

  network_interface {
    network_id       = "${data.vsphere_network.vm_network.id}"
    adapter_type     = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid    = "${data.vsphere_virtual_machine.template.id}"
  }
}
