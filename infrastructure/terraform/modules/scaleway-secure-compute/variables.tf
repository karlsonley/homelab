variable "name" {
  type        = string
  description = "The name to use for this instance"
}

variable "project_id" {
  type        = string
  description = "The project ID to use for this instance"
}

variable "sequence_number" {
  type        = string
  description = "The sequence number to suffix resource names with"
}

variable "public_ssh_key" {
  type        = string
  description = "The public SSH key to add to this instance for authentication"
}

variable "image" {
  type        = string
  description = "The image to use while provisioning this instance"
  default     = "debian_bookworm"
}

variable "type" {
  type        = string
  description = "The type of instance to provision"
  default     = "STARDUST1-S"
}

variable "root_volume_size_gb" {
  type        = number
  description = "The size in GB to use for the root volume for this instance"
  default     = 20
}

variable "tags" {
  type        = list(string)
  description = "A list of tags to assign to this instance"
  default     = null
}

variable "security_group_rules" {
  type = set(object({
    protocol = string
    port     = number
    ip_range = string
  }))
  description = <<-EOT
    A set of the security group rules to add to this instance
    - protocol `string`: TCP, UDP, ICMP or ANY
    - port     `number`: The port to use for this rule
    - ip_range `string`: The IP CIDR range to use for this rule
  EOT
  default     = []
}
