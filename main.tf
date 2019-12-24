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
  # name = "US Datacenter"
  name = "dc1"
}

data "vsphere_datastore" "datastore" {
  # name          = "Synology-DS1"
  name          = "datastore1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  # name          = "General Cluster/Infrastructure"
  name          = "cluster1/Resources"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "public"
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# resource "vsphere_virtual_machine" "vm" {
#   name             = "terraform-test"
#   resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
#   datastore_id     = "${data.vsphere_datastore.datastore.id}"

#   num_cpus = 2
#   memory   = 1024
#   guest_id = "other3xLinux64Guest"

#   network_interface {
#     network_id = "${data.vsphere_network.network.id}"
#   }

#   disk {
#     label = "disk0"
#     size  = 20
#   }
# }

# module "virtual_machines" {
#   source                     = "vancluever/terraform-vsphere-virtual-machine"
#   version                    = "1.0.0"
#   datacenter                 = "dc1"
#   datastore                  = "datastore1"
#   disk_size                  = "10"
#   guest_id                   = "otherLinuxGuest"
#   memory                     = "2048"
#   network                    = "network1"
#   resource_pool              = "cluster1/Resources"
#   vm_count                   = "3"
#   vm_name_prefix             = "srv"
# }
