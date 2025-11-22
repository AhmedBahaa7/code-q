variable "nodes" {
  description = "Map of node configurations"
  type = map(object({
    ami                 = string
    instance_type       = string
    key_name            = string
    subnet_id           = string
    security_group_ids  = list(string)
    root_volume_size    = number
    associate_public_ip = bool
    user_data           = optional(string)  
  }))
}
