terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
    vcd = {
      source = "vmware/vcd"
      version = "3.7.0"
    }
    http-full = {
      source = "salrashid123/http-full"
      version = "1.3.1"
    }
    time = {
      source = "hashicorp/time"
      version = "0.8.0"
    }
  }
}

provider "random" {
}
provider "http-full" { 
}
provider "time" {
}

provider "vcd" {
  user                 = var.vcd_user
  password             = var.vcd_pass
  auth_type            = "integrated"
  org                  = var.vcd_org
  vdc                  = var.vcd_vdc
  url                  = var.vcd_url
  max_retry_timeout    = 10
  allow_unverified_ssl = false
}
resource "random_integer" "port_frontend_value" {
  min = 1024
  max = 65535
  seed = timestamp()
}

resource "random_integer" "port_ssh_value" {
  min = 1024
  max = 65535
  seed = timeadd(timestamp(), "5s")
}



