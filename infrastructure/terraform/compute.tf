data "scaleway_account_project" "default" {
  name = "default"
}

data "http" "ipv4" {
  url = "https://ipv4.icanhazip.com"
}

module "pangolin_compute_001" {
  source = "./modules/scaleway-secure-compute"

  name            = "pangolin"
  sequence_number = "001"
  project_id      = data.scaleway_account_project.default.id
  public_ssh_key  = file("~/.ssh/scaleway_vm_pangolin.pub")

  security_group_rules = [
    # SSH
    {
      protocol = "TCP"
      port     = 22
      ip_range = "${chomp(data.http.ipv4.body)}/32"
    },
    # HTTP
    {
      protocol = "TCP"
      port     = "80"
      ip_range = "${chomp(data.http.ipv4.body)}/32"
    },
    # HTTPS
    {
      protocol = "TCP"
      port     = "443"
      ip_range = "0.0.0.0/0"
    },
    # WireGuard
    {
      protocol = "UDP"
      port     = "51820"
      ip_range = "0.0.0.0/0"
    },
  ]

  tags = ["pangolin"]
}
