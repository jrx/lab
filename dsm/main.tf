resource "synology_api" "foo" {
  api     = "SYNO.Core.System"
  method  = "info"
  version = 1
  parameters = {
    "query" = "all"
  }
}

output "result" {
  value = synology_api.foo.result
}

# resource "synology_core_package" "nomad" {
#   name = "HashiCorp Nomad"
#   url = "https://github.com/prabirshrestha/synology-nomad/releases/download/1.9.3-1000/nomad_1.9.3_linux_amd64.spk"
# }

