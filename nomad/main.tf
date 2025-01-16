resource "nomad_job" "adguard" {
  jobspec = templatefile(
    "${path.module}/jobs/adguard.hcl.tmpl", {
      version = "latest",
  })
}
