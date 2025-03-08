data "adguard_config" "test" {}

output "result" {
  value = data.adguard_config.test
}

# resource "adguard_config" "test" {

#   filtering = {
#     update_interval = 24
#   }

#   safebrowsing = false

#   safesearch = {
#     enabled  = false
#     services = ["youtube", "google"]
#   }

#   querylog = {
#     enabled             = false
#     interval            = 2160
#     anonymize_client_ip = false
#     ignored             = ["example.com"]
#   }

#   stats = {
#     enabled  = true
#     interval = 24
#     ignored  = ["example.com"]
#   }

#   blocked_services = ["4chan"]

#   dns = {
#     upstream_dns = [
#       "tls://8.8.8.8",
#       "tls://8.8.4.4",
#       "https://8.8.8.8/dns-query",
#       "https://8.8.4.4/dns-query",
#       "tls://1.1.1.1",
#       "tls://1.0.0.1",
#       "tls://162.159.36.1",
#       "https://1.1.1.1/dns-query",
#       "https://1.0.0.1/dns-query",
#       "https://162.159.36.1/dns-query",
#     ]
#   }

#   dhcp = {
#     interface = "bond0"
#     enabled   = "false"

#     ipv4_settings = {
#       gateway_ip     = "192.168.250.1"
#       subnet_mask    = "255.255.255.0"
#       range_start    = "192.168.250.10"
#       range_end      = "192.168.250.100"
#       lease_duration = 7200
#     }

#     static_leases = [
#       {
#         mac      = "00:11:22:33:44:55"
#         ip       = "192.168.250.20"
#         hostname = "test-lease-1"
#       },
#       {
#         mac      = "aa:bb:cc:dd:ee:ff"
#         ip       = "192.168.250.30"
#         hostname = "test-lease-2"
#       }
#     ]
#   }

#   tls = {
#     enabled           = false
#     server_name       = "Test AdGuard Home"
#     certificate_chain = "/opt/adguardhome/ssl/chain.crt"
#     private_key       = "/opt/adguardhome/ssl/server.key"
#   }
# }