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

variable "vsphere_folder" {}

variable "vsphere_datastore" {}

variable "vsphere_network" {}

variable "vsphere_virtual_machine_template" {}

variable "vsphere_virtual_machine_name" {}

# Ansible details
variable "ansible_usr" {}

variable "ansible_pwd" {}

variable "ansible_playbook_dir" {}

variable "ansible_roles_path" {}

variable "ansible_play" {}

# Linux details
variable "linux_options_domain" {}