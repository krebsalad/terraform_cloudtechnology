# add the provider
provider "libvirt" {
 uri = "qemu:///system"
}

# create pool
resource "libvirt_pool" "ubuntu" {
  name = "ubuntu-pool"
  type = "dir"
  path = "/tmp/terraform-provider-ubuntu-pool-images/"
}

# create image
resource "libvirt_volume" "image-qcow2" {
 name = "ubuntu-amd64.qcow2"
 pool = libvirt_pool.ubuntu.name
 source ="${path.module}/downloads/bionic-server-cloudimg-amd64.img"
 format = "qcow2"
}

# cloudinit
resource "libvirt_cloudinit_disk" "commoninit" {
  name = "commoninit.iso"
  pool = libvirt_pool.ubuntu.name
  user_data = data.template_file.user_data.rendered
}

# Use CloudInit to add the instance
data "template_file" "user_data" {
   template = file("${path.module}/cloud_init.cfg")
}

# Define KVM domain to create
resource "libvirt_domain" "test-domain" {
  name   = "test-vm-ubuntu"
  memory = "1024"
  vcpu   = 1

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_name = "default"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

    disk {
    volume_id = libvirt_volume.image-qcow2.id
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}


