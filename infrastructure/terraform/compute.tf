data "scaleway_account_project" "default" {
  name = "default"
}

module "pangolin_compute_001" {
  source = "./modules/scaleway-secure-ipv6-compute"

  name            = "pangolin"
  sequence_number = "001"
  project_id      = data.scaleway_account_project.default.id
  public_ssh_key  = file("~/.ssh/scaleway_vm_pangolin.pub")

  tags = ["pangolin"]
}
