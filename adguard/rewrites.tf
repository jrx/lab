
# Router

resource "adguard_rewrite" "fritz_box" {
  domain = "fritz.box"
  answer = "192.168.178.1"
}

resource "adguard_rewrite" "fritz_repeater" {
  domain = "fritz.repeater"
  answer = "192.168.178.28"
}

# Synology DS224+

resource "adguard_rewrite" "ds224" {
  domain = "ds224"
  answer = "192.168.178.2"
}

resource "adguard_rewrite" "ds224_lan" {
  domain = "ds224.lan"
  answer = "192.168.178.2"
}
resource "adguard_rewrite" "ds224_luene_org" {
  domain = "ds224.luene.org"
  answer = "192.168.178.2"
}

# Synology DS918+

resource "adguard_rewrite" "ds918" {
  domain = "ds918"
  answer = "192.168.178.9"
}

resource "adguard_rewrite" "ds918_lan" {
  domain = "ds918.lan"
  answer = "192.168.178.9"
}

resource "adguard_rewrite" "ds918_luene_org" {
  domain = "ds918.luene.org"
  answer = "192.168.178.9"
}

# Mac Mini M4

resource "adguard_rewrite" "mini" {
  domain = "mini"
  answer = "192.168.178.4"
}

resource "adguard_rewrite" "mini_lan" {
  domain = "mini.lan"
  answer = "192.168.178.4"
}

resource "adguard_rewrite" "mini_luene_org" {
  domain = "mini.luene.org"
  answer = "192.168.178.4"
}

# Services

resource "adguard_rewrite" "luene_org" {
  domain = "luene.org"
  answer = "192.168.178.2"
}

resource "adguard_rewrite" "luene_org_glob" {
  domain = "*.luene.org"
  answer = "192.168.178.21"
}

resource "adguard_rewrite" "lan_glob" {
  domain = "*.lan"
  answer = "192.168.178.21"
}

resource "adguard_rewrite" "test_luene_org_glob" {
  domain = "*.test.luene.org"
  answer = "192.168.178.91"
}

resource "adguard_rewrite" "test_lan_glob" {
  domain = "*.test.lan"
  answer = "192.168.178.91"
}

resource "adguard_rewrite" "vault_lan" {
  domain = "vault.lan"
  answer = "192.168.178.20"
}

resource "adguard_rewrite" "vault_test_lan" {
  domain = "vault.test.lan"
  answer = "192.168.178.90"
}

# VMs

resource "adguard_rewrite" "lab" {
  domain = "lab"
  answer = "192.168.178.5"
}

resource "adguard_rewrite" "lab_lan" {
  domain = "lab.lan"
  answer = "192.168.178.5"
}

resource "adguard_rewrite" "lab_luene_org" {
  domain = "lab.luene.org"
  answer = "192.168.178.5"
}

resource "adguard_rewrite" "pvm0" {
  domain = "pvm0"
  answer = "192.168.178.20"
}

resource "adguard_rewrite" "pvm0_lan" {
  domain = "pvm0.lan"
  answer = "192.168.178.20"
}

resource "adguard_rewrite" "pvm0_luene_org" {
  domain = "pvm0.luene.org"
  answer = "192.168.178.20"
}

resource "adguard_rewrite" "pvm0_luene_org_glob" {
  domain = "*.pvm0.luene.org"
  answer = "192.168.178.20"
}

resource "adguard_rewrite" "pvm1" {
  domain = "pvm1"
  answer = "192.168.178.21"
}

resource "adguard_rewrite" "pvm1_lan" {
  domain = "pvm1.lan"
  answer = "192.168.178.21"
}

resource "adguard_rewrite" "pvm1_luene_org" {
  domain = "pvm1.luene.org"
  answer = "192.168.178.21"
}

resource "adguard_rewrite" "pvm1_luene_org_glob" {
  domain = "*.pvm1.luene.org"
  answer = "192.168.178.21"
}

resource "adguard_rewrite" "tvm0" {
  domain = "tvm0"
  answer = "192.168.178.90"
}

resource "adguard_rewrite" "tvm0_lan" {
  domain = "tvm0.lan"
  answer = "192.168.178.90"
}

resource "adguard_rewrite" "tvm0_luene_org" {
  domain = "tvm0.luene.org"
  answer = "192.168.178.90"
}

resource "adguard_rewrite" "tvm0_luene_org_glob" {
  domain = "*.tvm0.luene.org"
  answer = "192.168.178.90"
}

resource "adguard_rewrite" "tvm1" {
  domain = "tvm1"
  answer = "192.168.178.91"
}

resource "adguard_rewrite" "tvm1_lan" {
  domain = "tvm1.lan"
  answer = "192.168.178.91"
}

resource "adguard_rewrite" "tvm1_luene_org" {
  domain = "tvm1.luene.org"
  answer = "192.168.178.91"
}

resource "adguard_rewrite" "tvm1_luene_org_glob" {
  domain = "*.tvm1.luene.org"
  answer = "192.168.178.91"
}

resource "adguard_rewrite" "tvm2" {
  domain = "tvm2"
  answer = "192.168.178.92"
}

resource "adguard_rewrite" "tvm2_lan" {
  domain = "tvm2.lan"
  answer = "192.168.178.92"
}

resource "adguard_rewrite" "tvm2_luene_org" {
  domain = "tvm2.luene.org"
  answer = "192.168.178.92"
}

resource "adguard_rewrite" "tvm2_luene_org_glob" {
  domain = "*.tvm2.luene.org"
  answer = "192.168.178.92"
}