provider "vsphere" {
  user                 = var.vsphere_config.user
  password             = var.vsphere_config.password
  vsphere_server       = var.vsphere_config.server
  
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = "OE-KL-DC"
}

data "vsphere_datastore" "datastore" {
  name          = "DATA_LUN"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_host" "host" {
  name          = "10.3.13.197"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network_dmz2" {
  name          = "DMZ2 Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "ubuntu2404lts" {
  name          = "Ubuntu24.04_LTS"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}