terraform {
  required_providers {
    http = {}
  }
}

data "http" "this" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  ip_json = jsondecode(data.http.this.response_body)
}

output "public_ip" {
  value = local.ip_json.ip
}