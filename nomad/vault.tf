# Generate another private key. This one will be used
# To create the certs on your Vault nodes
resource "tls_private_key" "server" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_cert_request" "server" {
  private_key_pem = tls_private_key.server.private_key_pem

  subject {
    common_name = "vault.vm01.luene.org"
  }

  dns_names = [
    "vault.vm01.luene.org",
    var.vault_shared_san,
    "localhost",
  ]

  ip_addresses = [
    "127.0.0.1",
    "192.168.178.91",
  ]
}

resource "tls_locally_signed_cert" "server" {
  cert_request_pem   = tls_cert_request.server.cert_request_pem
  ca_private_key_pem = file("${path.module}/../local/rootCA.key")
  ca_cert_pem        = file("${path.module}/../local/rootCA.crt")

  validity_period_hours = 17520 # 2 years

  allowed_uses = [
    "client_auth",
    "digital_signature",
    "key_agreement",
    "key_encipherment",
    "server_auth",
  ]
}

resource "nomad_job" "vault" {
  jobspec = templatefile(
    "${path.module}/jobs/vault.hcl.tmpl", {
      version = "latest",
      key     = tls_private_key.server.private_key_pem
      crt     = tls_locally_signed_cert.server.cert_pem
      ca      = tls_locally_signed_cert.server.ca_cert_pem
  })
}

resource "nomad_job" "vault-unsealer" {
  jobspec = file(
  "${path.module}/jobs/vault-unsealer.hcl.tmpl")
}
