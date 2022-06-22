module "VNLHPROD-K8M01" {
  source                       = "./VNLHPROD-K8M01"
  vsphere_host                 = var.vsphere_host
  vsphere_usr                  = var.vsphere_usr
  vsphere_pwd                  = var.vsphere_pwd
  vsphere_datacenter           = var.vsphere_datacenter
  vsphere_network              = var.vsphere_network
  vsphere_template             = var.vsphere_template
  vsphere_folder               = var.vsphere_folder
  vsphere_resource_pool        = var.vsphere_resource_pool
  vsphere_datastore            = var.vsphere_datastore
  ssh_usr                      = var.ssh_usr
  ssh_pwd                      = var.ssh_pwd
  ansible_usr                  = var.ansible_usr
  ansible_config               = var.ansible_config
  ansible_base_playbook        = var.ansible_base_playbook
  ansible_additional_playbooks = var.ansible_additional_playbooks
  linux_options_domain         = var.linux_options_domain
  dns_server_list              = var.dns_server_list
}

module "VNLHPROD-K8W01" {
  source                       = "./VNLHPROD-K8W01"
  vsphere_host                 = var.vsphere_host
  vsphere_usr                  = var.vsphere_usr
  vsphere_pwd                  = var.vsphere_pwd
  vsphere_datacenter           = var.vsphere_datacenter
  vsphere_network              = var.vsphere_network
  vsphere_template             = var.vsphere_template
  vsphere_folder               = var.vsphere_folder
  vsphere_resource_pool        = var.vsphere_resource_pool
  vsphere_datastore            = var.vsphere_datastore
  ssh_usr                      = var.ssh_usr
  ssh_pwd                      = var.ssh_pwd
  ansible_usr                  = var.ansible_usr
  ansible_config               = var.ansible_config
  ansible_base_playbook        = var.ansible_base_playbook
  ansible_additional_playbooks = var.ansible_additional_playbooks
  linux_options_domain         = var.linux_options_domain
  dns_server_list              = var.dns_server_list
}

module "VNLHPROD-K8W02" {
  source                       = "./VNLHPROD-K8W02"
  vsphere_host                 = var.vsphere_host
  vsphere_usr                  = var.vsphere_usr
  vsphere_pwd                  = var.vsphere_pwd
  vsphere_datacenter           = var.vsphere_datacenter
  vsphere_network              = var.vsphere_network
  vsphere_template             = var.vsphere_template
  vsphere_folder               = var.vsphere_folder
  vsphere_resource_pool        = var.vsphere_resource_pool
  vsphere_datastore            = var.vsphere_datastore
  ssh_usr                      = var.ssh_usr
  ssh_pwd                      = var.ssh_pwd
  ansible_usr                  = var.ansible_usr
  ansible_config               = var.ansible_config
  ansible_base_playbook        = var.ansible_base_playbook
  ansible_additional_playbooks = var.ansible_additional_playbooks
  linux_options_domain         = var.linux_options_domain
  dns_server_list              = var.dns_server_list
}

module "VNLHPROD-K8W03" {
  source                       = "./VNLHPROD-K8W03"
  vsphere_host                 = var.vsphere_host
  vsphere_usr                  = var.vsphere_usr
  vsphere_pwd                  = var.vsphere_pwd
  vsphere_datacenter           = var.vsphere_datacenter
  vsphere_network              = var.vsphere_network
  vsphere_template             = var.vsphere_template
  vsphere_folder               = var.vsphere_folder
  vsphere_resource_pool        = var.vsphere_resource_pool
  vsphere_datastore            = var.vsphere_datastore
  ssh_usr                      = var.ssh_usr
  ssh_pwd                      = var.ssh_pwd
  ansible_usr                  = var.ansible_usr
  ansible_config               = var.ansible_config
  ansible_base_playbook        = var.ansible_base_playbook
  ansible_additional_playbooks = var.ansible_additional_playbooks
  linux_options_domain         = var.linux_options_domain
  dns_server_list              = var.dns_server_list
}
