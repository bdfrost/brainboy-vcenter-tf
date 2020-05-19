# terraform {
#   backend "remote" {
#     hostname = "app.terraform.io"
#     organization = "froste"

#     workspaces {
#       name = "brainboy-vcenter-tf"
#     }
#   }
# }

provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere_cluster}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.vsphere_resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vsphere_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "k3s_template" {
  name          = "${var.k3s_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "k3s-master" {
  name             = "k3s-master"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 3072
  guest_id = "${data.vsphere_virtual_machine.k3s_template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.k3s_template.scsi_type}"
  wait_for_guest_net_timeout = 0
  wait_for_guest_net_routable = false

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.k3s_template.network_interface_types[0]}"
    use_static_mac = true
    mac_address = "${var.k3s_master_mac}"
  }

  disk {
    label = "disk0"
    size             = "${data.vsphere_virtual_machine.k3s_template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.k3s_template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.k3s_template.disks.0.thin_provisioned}"
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.k3s_template.id}"

    customize {
      
      linux_options {
        host_name  = "k3s-master"
        domain = "brainboy.local.lan"
        time_zone = "America/Chicago"
      }

      network_interface {        
      }
    }
  }
}

resource "vsphere_virtual_machine" "k3s-node-1" {
  name             = "k3s-node-1"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 3072
  guest_id = "${data.vsphere_virtual_machine.k3s_template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.k3s_template.scsi_type}"
  wait_for_guest_net_timeout = 0
  wait_for_guest_net_routable = false

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.k3s_template.network_interface_types[0]}"
    use_static_mac = true
    mac_address = "${var.k3s_node_1_mac}"
  }

  disk {
    label = "disk0"
    size             = "${data.vsphere_virtual_machine.k3s_template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.k3s_template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.k3s_template.disks.0.thin_provisioned}"
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.k3s_template.id}"

    customize {

      linux_options {
        host_name  = "k3s-node-1"
        domain = "brainboy.local.lan"
        time_zone = "America/Chicago"
      }

      network_interface {
      }
    }
  }
}

resource "vsphere_virtual_machine" "k3s-node-2" {
  name             = "k3s-node-2"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 3072
  guest_id = "${data.vsphere_virtual_machine.k3s_template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.k3s_template.scsi_type}"
  wait_for_guest_net_timeout = 0
  wait_for_guest_net_routable = false

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.k3s_template.network_interface_types[0]}"
    use_static_mac = true
    mac_address = "${var.k3s_node_2_mac}"
  }

  disk {
    label = "disk0"
    size             = "${data.vsphere_virtual_machine.k3s_template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.k3s_template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.k3s_template.disks.0.thin_provisioned}"
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.k3s_template.id}"

    customize {

      linux_options {
        host_name  = "k3s-node-2"
        domain = "brainboy.local.lan"
        time_zone = "America/Chicago"
      }
    
      network_interface {
      }
    }
  }
}
