
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

resource "adguard_rewrite" "ds224_local" {
  domain = "ds224.local"
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

resource "adguard_rewrite" "ds918_local" {
  domain = "ds918.local"
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

resource "adguard_rewrite" "mini_local" {
  domain = "mini.local"
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
  answer = "192.168.178.2"
}

# VMs

resource "adguard_rewrite" "lab" {
  domain = "lab"
  answer = "192.168.178.5"
}

resource "adguard_rewrite" "lab_local" {
  domain = "lab.local"
  answer = "192.168.178.5"
}

resource "adguard_rewrite" "lab_luene_org" {
  domain = "lab.luene.org"
  answer = "192.168.178.5"
}

resource "adguard_rewrite" "vm01" {
  domain = "vm01"
  answer = "192.168.178.91"
}

resource "adguard_rewrite" "vm01_local" {
  domain = "vm01.local"
  answer = "192.168.178.91"
}

resource "adguard_rewrite" "vm01_luene_org" {
  domain = "vm01.luene.org"
  answer = "192.168.178.91"
}

resource "adguard_rewrite" "vm01_luene_org_glob" {
  domain = "*.vm01.luene.org"
  answer = "192.168.178.91"
}

resource "adguard_rewrite" "vm02" {
  domain = "vm02"
  answer = "192.168.178.92"
}

resource "adguard_rewrite" "vm02_local" {
  domain = "vm02.local"
  answer = "192.168.178.92"
}

resource "adguard_rewrite" "vm02_luene_org" {
  domain = "vm02.luene.org"
  answer = "192.168.178.92"
}

resource "adguard_rewrite" "vm02_luene_org_glob" {
  domain = "*.vm02.luene.org"
  answer = "192.168.178.92"
}