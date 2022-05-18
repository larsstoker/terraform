# Provider
provider "vsphere" {
  user = "${var.vsphere_usr}"
  password = "${var.vsphere_pwd}"
  vsphere_server = "${var.vsphere_host}"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_datastore" "datastore" {
  name = "${var.vsphere_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name = "${var.vsphere_resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_folder" "folder" {
  path = "${var.vsphere_datacenter}/vm/${var.vsphere_folder}"
}

data "vsphere_network" "network" {
  name = "${var.vsphere_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name = "${var.vsphere_virtual_machine_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# Resource
resource "vsphere_virtual_machine" "cloned_virtual_machine" {
  name = "${var.vsphere_virtual_machine_name}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id = "${data.vsphere_datastore.datastore.id}"
  folder = "${var.vsphere_folder}"

  num_cpus = "${data.vsphere_virtual_machine.template.num_cpus}"
  memory = "${data.vsphere_virtual_machine.template.memory}"
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label = "disk0"
    size = "${data.vsphere_virtual_machine.template.disks.0.size}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "${var.vsphere_virtual_machine_name}"
        domain = "${var.linux_options_domain}"
      }

      network_interface {}
    }
  }
  
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ANSIBLE_FORCE_COLOR=1 ANSIBLE_ROLES_PATH=${var.ansible_roles_path} ansible-playbook -u ${var.ansible_usr} -e 'ansible_password=${var.ansible_pwd}' -i '${self.default_ip_address}', ${var.ansible_playbook_dir}/${var.ansible_base_playbook}"
  }
}