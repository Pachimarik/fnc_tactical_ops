data "vcd_edgegateway" "egw" {
  name     = var.vcd_edge_gw
}

data "vcd_network_direct" "net" {
  name = var.vcd_ext_ntwrk_name
}

resource "vcd_nsxv_dnat" "dnat-frontend" {
  edge_gateway = var.vcd_edge_gw
  network_name = "inet_user1"
  network_type = "ext"

  enabled         = true
  logging_enabled = true
  description     = "${var.project}-HTTPS"

  original_address = data.vcd_edgegateway.egw.default_external_network_ip
  original_port    = random_integer.port_frontend_value.result

  translated_address = vcd_vapp_vm.web1.network[0].ip
  translated_port    = 443
  protocol           = "tcp"
}

resource "vcd_nsxv_dnat" "dnat-ssh" {
  edge_gateway = var.vcd_edge_gw
  network_name = "inet_user1"
  network_type = "ext"

  enabled         = true
  logging_enabled = true
  description     = "${var.project}-SSH-CML"

  original_address = data.vcd_edgegateway.egw.default_external_network_ip
  original_port    = random_integer.port_ssh_cml_value.result

  translated_address = vcd_vapp_vm.web1.network[0].ip
  translated_port    = 22
  protocol           = "tcp"
}
resource "vcd_nsxv_dnat" "dnat-ssh-machine" {
  edge_gateway = var.vcd_edge_gw
  network_name = "inet_user1"
  network_type = "ext"

  enabled         = true
  logging_enabled = true
  description     = "${var.project}-SSH-OS"

  original_address = data.vcd_edgegateway.egw.default_external_network_ip
  original_port    = random_integer.port_ssh_os_value.result

  translated_address = vcd_vapp_vm.web1.network[0].ip
  translated_port    = 1122
  protocol           = "tcp"
}