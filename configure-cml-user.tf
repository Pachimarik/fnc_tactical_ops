locals {
  cml_url = "https://${data.vcd_edgegateway.egw.default_external_network_ip}:${vcd_nsxv_dnat.dnat-frontend.original_port}"
  bearer = replace(data.http.get_bearer.response_body,"\"","")
  result = data.http.change_pw.response_body
  checked = 0
  username = var.cml_username == "" ? random_pet.vapp-name.id: var.cml_username
  password = var.cml_passwd == "" ? random_password.password.result : var.cml_passwd
}

resource "time_sleep" "waiter" {
  depends_on = [vcd_nsxv_dnat.dnat-frontend]

  create_duration = "1m"
}

data "http" "get_bearer" {
  provider = http-full
  url = "${local.cml_url}/api/v0/authenticate"
  method = "POST"
  insecure_skip_verify = true

  request_headers = {
    Accept = "application/json"
  }

  request_body = jsonencode({
    username = "admin",
    password = "P@ssw0rd"
  })

  lifecycle {
    postcondition {
      condition     = contains([200], self.status_code)
      error_message = "Status code invalid"
    }
  }
  depends_on = [
    vcd_vapp_vm.web1,
    vcd_nsxv_dnat.dnat-frontend,
    time_sleep.waiter
  ]
  
}
data "http" "change_pw"{
    provider = http-full
  url = "${local.cml_url}/api/v0/users/00000000-0000-4000-a000-000000000000"
  method = "PATCH"
  insecure_skip_verify = true

  request_headers = {
    Accept = "application/json"
    Authorization = "Bearer ${local.bearer}"
  }

  request_body = jsonencode({
    username = local.username
    password = {
        old_password = "P@ssw0rd"
        new_password = local.password
    }
  })

  lifecycle {
    postcondition {
      condition     = contains([200], self.status_code)
      error_message = "Status code invalid"
    }
  }
  depends_on = [
    data.http.get_bearer
  ]
    
}
# data "http" "get_uuid" {
#   provider = http-full
#   url = "${local.cml_url}/api/v0/users/admin/id"
#   method = "GET"
#   insecure_skip_verify = true

#   request_headers = {
#     Accept = "application/json"
#     Authorization =  "Bearer ${local.bearer}"
#   } 
#   lifecycle {
#     postcondition {
#       condition     = contains([200], self.status_code)
#       error_message = "Status code invalid"
#     }
#   }
#   depends_on = [
#     data.http.get_bearer    
#   ]
# }