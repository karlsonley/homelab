resource "scaleway_instance_ip" "ipv6" {
  project_id = var.project_id
  type       = "routed_ipv6"
}

resource "scaleway_instance_security_group" "this" {
  name                    = join("-", ["isg", var.name, var.sequence_number])
  project_id              = var.project_id
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"
  external_rules          = true
}

resource "scaleway_instance_security_group_rules" "this" {
  security_group_id = scaleway_instance_security_group.this.id

  inbound_rule {
    action   = "accept"
    port     = 22
    ip_range = "::/0"
  }
}

resource "scaleway_iam_ssh_key" "this" {
  name       = join("-", ["key", var.name, var.sequence_number])
  public_key = var.public_ssh_key
}

resource "scaleway_instance_server" "this" {
  name       = join("-", ["vm", var.name, var.sequence_number])
  project_id = var.project_id
  type       = var.type
  image      = var.image
  tags       = var.tags

  admin_password_encryption_ssh_key_id = scaleway_iam_ssh_key.this.id
  ip_id                                = scaleway_instance_ip.ipv6.id
  security_group_id                    = scaleway_instance_security_group.this.id

  root_volume {
    delete_on_termination = false
    volume_type           = "sbs_volume"
    sbs_iops              = 5000
    size_in_gb            = var.root_volume_size_gb
  }
}
