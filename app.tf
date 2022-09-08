resource "vcd_vapp" "web" {
  name = "${var.project}"

  metadata = {
    project = "${var.project}"
  }
}

resource "vcd_vapp_org_network" "direct-network" {
  vapp_name        = vcd_vapp.web.name
  org_network_name = data.vcd_network_direct.net.name
}

resource "vcd_vapp_vm" "web1" {
  vapp_name = vcd_vapp.web.name
  name      = "${var.project}-VM1"

  catalog_name  = "CML_Templates"
  template_name = "CML2_Template_Production"
  expose_hardware_virtualization = true

  memory = 8192
  cpus   = 2

  network {
    type               = "org"
    name               = vcd_vapp_org_network.direct-network.org_network_name
    ip_allocation_mode = "POOL"
  }
  # guest_properties = {
  #   "local-hostname"      = "cml-controller"
  #   "user-data"           = base64encode(file("${path.module}/userdata.yaml"))
  # }

 metadata = {
   project = "${var.project}"
 }
}
