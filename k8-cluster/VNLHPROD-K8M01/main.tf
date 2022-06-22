# Provider
provider "vsphere" {
  user                 = var.vsphere_usr
  password             = var.vsphere_pwd
  vsphere_server       = var.vsphere_host
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_folder" "folder" {
  path = "${var.vsphere_datacenter}/vm/${var.vsphere_folder}"
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

##vSphere VMs

resource "vsphere_virtual_machine" "vm" {
  name             = "VNLHPROD-K8M01"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 4
  memory   = 4096
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "VNLHPROD-K8M01"
        domain    = var.linux_options_domain
      }

      network_interface {
        ipv4_address = "10.0.20.61"
        ipv4_netmask = 24
      }

      ipv4_gateway = "10.0.20.1"
      dns_server_list = var.dns_server_list
    }
  }
  
  connection {
    type     = "ssh"
    user     = var.ssh_usr
    password = var.ssh_pwd
    host     = vsphere_virtual_machine.vm.default_ip_address
  }

  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=${var.ansible_config} ansible-playbook -u ${var.ansible_usr} -i '${self.default_ip_address}', --extra-vars 'master_ip=${self.default_ip_address}' ${var.ansible_base_playbook} ${var.ansible_additional_playbooks} /home/lars/projects/automation/ansible/playbooks/kubernetes-cluster-create.yml"
  }
}

# Output
output "ip" {
  value = vsphere_virtual_machine.vm.default_ip_address
}