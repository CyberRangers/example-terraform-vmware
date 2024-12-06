resource "vsphere_virtual_machine" "vm" {
    count = 1
    name             = "CBR${count.index + 1}-Ubuntu"
    resource_pool_id = data.vsphere_host.host.resource_pool_id
    datastore_id     = data.vsphere_datastore.datastore.id
    num_cpus         = 2
    memory           = 2048
    guest_id         = "ubuntu64Guest"
    firmware = "efi"

    clone {
        template_uuid = data.vsphere_virtual_machine.ubuntu2404lts.id

        customize {
            linux_options {
                host_name = "CBR${count.index + 1}-Ubuntu"
                domain    = "local"
            }

            network_interface {
                ipv4_address = "10.3.13.${100 + count.index + 1}"
                ipv4_netmask = 24
            }

            network_interface {
                ipv4_address = "10.20.13.${100 + count.index + 1}"
                ipv4_netmask = 24
            }

            ipv4_gateway  = "10.3.13.1"
            dns_server_list = ["8.8.8.8"]
        }
    }
  
    network_interface {
        network_id      = data.vsphere_network.network.id
        adapter_type    = "vmxnet3"
    }

    network_interface {
        network_id      = data.vsphere_network.network_dmz2.id
        adapter_type    = "vmxnet3"
    }

    disk {
        label = "disk0"
        size  = 25
    }
}

resource "vsphere_virtual_machine" "vm_2" {
    count = 1
    name             = "CBR${count.index + 2}-Ubuntu"
    resource_pool_id = data.vsphere_host.host.resource_pool_id
    datastore_id     = data.vsphere_datastore.datastore.id
    num_cpus         = 2
    memory           = 2048
    guest_id         = "ubuntu64Guest"
    firmware = "efi"

    clone {
        template_uuid = data.vsphere_virtual_machine.ubuntu2404lts.id

        customize {
            linux_options {
                host_name = "CBR${count.index + 2}-Ubuntu"
                domain    = "local"
            }

            network_interface {
                ipv4_address = "10.20.13.${100 + count.index + 2}"
                ipv4_netmask = 24
            }

            ipv4_gateway  = "10.20.13.1"
            dns_server_list = ["8.8.8.8"]
        }
    }
  
    network_interface {
        network_id      = data.vsphere_network.network_dmz2.id
        adapter_type    = "vmxnet3"
    }

    disk {
        label = "disk0"
        size  = 25
    }
}