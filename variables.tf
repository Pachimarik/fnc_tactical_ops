variable "vsphere_user" {
    description = "login"  
    default = "avildanov@lab.lan"
}

variable "vsphere_pass" {
    description = "password"
    default = "tooQu4ou!"
}

variable "vsphere_server1" {
    description = "ip of FQDN vsphere server"
    default = "192.168.15.58"
}

variable "vsphere_dc1" {
    description = "name datacenter"
    default = "DC1"
}

variable "instance_count" {
    description = "count vms"
    default = 1
}

variable "instance_cpu" {
    description = "count vCPU`s"
    default = 8  
}

variable "instance_ram" {
    description = "count RAM (MB)"
    default = 16384
}