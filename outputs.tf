output "local_ip" {
  value = vcd_vapp_vm.web1.network[0].ip
}
output "ext_ip" {
  value = data.vcd_edgegateway.egw.default_external_network_ip
}
output "port_gui" {
  value = vcd_nsxv_dnat.dnat-frontend.original_port
}
output "port_ssh_cml" {
  value = vcd_nsxv_dnat.dnat-ssh.original_port
}
output "port_ssh_os" {
  value = vcd_nsxv_dnat.dnat-ssh-machine.original_port
}
output "connection_url" {
  value = "https://${data.vcd_edgegateway.egw.default_external_network_ip}:${vcd_nsxv_dnat.dnat-frontend.original_port}/"
}
#output "bearer" {
#  value = local.result
#}
output "username" {
  value = var.cml_username
}
output "password" {
  value = var.cml_passwd
}