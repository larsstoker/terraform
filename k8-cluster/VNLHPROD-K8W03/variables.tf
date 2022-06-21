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

variable "vsphere_template" {
  description = "The name of the template."
}

# SSH details
variable "ssh_usr" {
  description = "The user ansible uses for SSH/WinRM connections."
}

variable "ssh_pwd" {
  description = "The password for the user specified in `ansible_usr`."
}

# Ansible details
variable "ansible_usr" {
  description = "The user for Ansible."
}

variable "ansible_config" {
  description = "The path to the ansible config file."
}

variable "ansible_base_playbook" {
  description = "The relative path to the playbook used to perform basic configuration."
}

variable "ansible_additional_playbooks" {
  description = "The relative path(s) to additional playbooks to run."
}

# Linux details
variable "linux_options_domain" {
  description = "The domain name for this machine."
}

variable "dns_server_list" {
  description = "A list of DNS servers."
  type = list
}