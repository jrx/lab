resource "nomad_job" "adguard" {
  jobspec = templatefile(
    "${path.module}/jobs/adguard.hcl.tmpl", {
      version = "latest",
  })
}

resource "nomad_job" "vault" {
  jobspec = templatefile(
    "${path.module}/jobs/vault.hcl.tmpl", {
      version = "latest",
  })
}

resource "nomad_job" "vault-unsealer" {
  jobspec = file(
  "${path.module}/jobs/vault-unsealer.hcl.tmpl")
}