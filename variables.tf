# VMware vSphere hitelesítési adatok egyetlen objektum változóban
variable "vsphere_config" {
    description = "VMware vSphere hitelesítési adatok és szerver információk"
    type = object({
        user     = string
        password = string
        server   = string
    })

    sensitive = true

    default = {
    user     = "administrator@vsphere.local"
    password = "rJ@B86rMkx!t37F"
    server   = "10.3.13.201"
  }
}