# Local values
locals {
  vsphere_datacenter    = var.vsphere_datacenter
  vsphere_datastore     = var.vsphere_datastore
  vsphere_resource_pool = var.vsphere_resource_pool
  vsphere_folder        = var.vsphere_folder
  vsphere_host          = var.vsphere_host
  vsphere_network       = var.vsphere_network
  nested_host_config    = var.nested_host_config
}

# Data
data "vsphere_datacenter" "dc" {
  name = local.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = local.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_folder" "folder" {
  path = "${local.vsphere_datacenter}/vm/${local.vsphere_folder}"
}

data "vsphere_network" "network" {
  name          = local.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host_system_id" {
  name          = local.vsphere_host
  datacenter_id = data.vsphere_datacenter.dc.id
}

# VM Deployment
resource "vsphere_virtual_machine" "vm" {
  for_each         = local.nested_host_config
  name             = each.value.name
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  folder           = var.vsphere_folder

  datacenter_id              = data.vsphere_datacenter.dc.id
  num_cpus                   = each.value.num_cpus
  memory                     = each.value.memory 
  
  nested_hv_enabled          = each.value.nested_hv_enabled
  host_system_id             = data.vsphere_host.host_system_id.id
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  disk {
    label       = "os"
    unit_number = 0
    size        = each.value.os_size
  }

  disk {
    label       = "vsan1"
    unit_number = 1
    size        = each.value.vsan1_size
  }

  disk {
    label       = "vsan2"
    unit_number = 2
    size        = each.value.vsan2_size
  }

  ovf_deploy {
    #!local_ovf_path       = each.value.local_ovf_path != null ? each.value.local_ovf_path : null
    remote_ovf_url       = each.value.remote_ovf_url #! != null ? each.value.remote_ovf_url : null
    ip_protocol          = "IPV4"
    ip_allocation_policy = "STATIC_MANUAL"
    disk_provisioning    = each.value.disk_provisioning
    ovf_network_map = {
      "Trunk-1" = data.vsphere_network.network.id
      "Trunk-2" = data.vsphere_network.network.id
      "Trunk-3" = data.vsphere_network.network.id
      "Trunk-4" = data.vsphere_network.network.id
    }
  }

  vapp {
    properties = {
      "guestinfo.hostname"  = each.value.name,
      "guestinfo.ipaddress" = each.value.ip_address,
      "guestinfo.netmask"   = each.value.netmask,
      "guestinfo.gateway"   = each.value.gateway,
      "guestinfo.vlan"      = each.value.vlan,
      "guestinfo.dns"       = each.value.dns,
      "guestinfo.domain"    = each.value.domain,
      "guestinfo.ntp"       = each.value.ntp,
      "guestinfo.password"  = each.value.password
    }
  }
  lifecycle {
    ignore_changes = [
      annotation,
      disk[0].io_share_count,
      disk[1].io_share_count,
      disk[2].io_share_count,
      vapp[0].properties,
    ]
  }
}