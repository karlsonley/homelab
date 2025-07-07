module "storage_terraform" {
  source = "./modules/scaleway-private-storage/"

  name               = "terraform"
  versioning_enabled = true
}

module "storage_backup" {
  source = "./modules/scaleway-private-storage/"

  name = "backup"
}
