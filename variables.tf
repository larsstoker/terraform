# vCenter details
variable "vsphere_usr" {
  default = "terraform"
}

variable "vsphere_pwd" {}

variable "vsphere_host" {
  default = "localhost"
}

variable "vsphere_datacenter" {}

variable "vsphere_resource_pool" {}

variable "vsphere_datastore" {}

variable "vsphere_network" {}

variable "vsphere_virtual_machine_template" {}

variable "vsphere_virtual_machine_name" {}