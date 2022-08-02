variable "domain_name" {
  type = string
}

variable "cname" {
  description = "CNAME of the EB Environment"
  type = string
}

variable "zone" {
  description = "Zone where the EB is located"
  type = string
}
