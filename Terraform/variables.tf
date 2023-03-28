variable "Prefix" {
  type        = string
  default     = "christopherwk6"
}

variable "Region" {
  type        = string
  default     = "uksouth"
}

variable "Network_ip" {
    type = string
    default = "192.168.0.0/16"
}

variable "K8sSubnet_ip" {
    type = string
    default = "192.168.2.0/24"
}

variable "AppSubnet_ip" {
    type = string
    default = "192.168.1.0/24"
}

variable "Ssh_PublicKey" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}

variable "Group_Id" {
  type = string
  default = "61ce29ea-4880-40fa-a958-ccfbb6b0d972"
  
}