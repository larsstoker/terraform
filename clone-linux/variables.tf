# vCenter details
variable "vsphere_usr" {
  default = "terraform"
  description = "The user name."
}

variable "vsphere_pwd" {
  description = "The password."
}

variable "vsphere_host" {
  default = "localhost"
  description = "The FQDN/IP of the host."
}

variable "vsphere_datacenter" {
  description = "The name of the datacenter."
}

variable "vsphere_resource_pool" {
  description = "The name of the resource pool."
}

variable "vsphere_folder" {
  description = "The absolute path of the folder."
}

variable "vsphere_datastore" {
  description = "The name of the datastore."
}

variable "vsphere_network" {
  description = "The name of the network."
}

variable "vsphere_virtual_machine_template" {
  description = "The name of the template."
}

variable "vsphere_virtual_machine_name" {
  description = "The name of the virtual machine."
}

# Ansible details

variable "ansible_base_dir" {
  description = "The absolute path to the ansible directory."
}
variable "ansible_base_playbook" {
  description = "The name of the playbook used to perform basic configuration."
}

# Linux details
variable "linux_options_domain" {
  description = "The domain name for this machine."
}