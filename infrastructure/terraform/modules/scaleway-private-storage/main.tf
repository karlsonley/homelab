resource "scaleway_object_bucket" "this" {
  name          = join("", ["st", "kms", var.name])
  region        = "nl-ams"
  force_destroy = false
  versioning {
    enabled = var.versioning_enabled
  }
}

resource "scaleway_object_bucket_acl" "this" {
  bucket = scaleway_object_bucket.this.id
  region = "nl-ams"
  acl    = "private"
}
