# provider
provider "libvirt" {
  uri = "qemu:///system"
}

# the variables
variable "pool_name"{
  description = "name of to create pool"
  type = "string"
}

variable "pool_dir"{
  description = "dir of the new pool"
  type = "string"
}

variable "domain_name"{
  description = "name of the image including the format"
  type = "string"
}

variable "image_name"{
  description = "name of the image including the format"
  type = "string"
}

variable "common_name"{
  description = "name of cloud init disk"
  type = "string"
}

variable "image_source"{
  description = "path to image source"
  type = "string"
}

variable "user_data_source"{
  description = "path to use data"
  type = "string"
}

variable "network_config_source"{
  description = ""
}

variable "domain_memory"{
  description = "name of the volume"
  type = "string"
}


# load data
data "template_file" "user_data" {
  template = file("${var.user_data_source}")
}

data "template_file" "network_config" {
  template = file("${var.network_config_source}")
}

# create pool
resource "libvirt_pool" "ubuntu" {
  name = "${var.pool_name}"
  type = "dir"
  path = "${var.pool_dir}"
}

# create image
resource "libvirt_volume" "image-qcow2"{
  name = "${var.image_name}"
  pool = libvirt_pool.ubuntu.name
  source = "${var.image_source}"   
  format = "qcow2"
}

# cloudinit
resource "libvirt_cloudinit_disk" "commoninit" {
  name = "${var.common_name}_commoninit.iso"
  pool = libvirt_pool.ubuntu.name
  user_data = "${data.template_file.user_data.rendered}"
  network_config = "${data.template_file.network_config.rendered}"
}

# Define KVM domain to create
resource "libvirt_domain" "virt-domain" {
  name   = "${var.domain_name}-${var.domain_memory}mb-1vcpu"
  memory = "${var.domain_memory}"
  vcpu   = 1

  cloudinit = "${libvirt_cloudinit_disk.commoninit.id}"

  network_interface {
    network_name = "default"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

    disk {
    volume_id = "${libvirt_volume.image-qcow2.id}"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}
