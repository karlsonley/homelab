variable "name" {
  type        = string
  description = "The name to use for this storage bucket. Will be prefixed with stkms automatically"
}


variable "versioning_enabled" {
  type        = bool
  description = "Whether to enable versioning on this private storage bucket"
  default     = false
}
