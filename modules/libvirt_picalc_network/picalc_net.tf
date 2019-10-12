# make sure qemu is running
provider "libvirt" {
  uri = "qemu:///system"
}

# let terraform follow lifecycle of network
resource "null_resource" "picalc_network" {
   provisioner "local-exec" {
      command = "virsh net-define ${path.module}/config/picalc_net_config.xml && virsh net-autostart picalc_net &&virsh net-start picalc_net"
      interpreter = ["/bin/bash", "-c"]
   }
   provisioner "local-exec" {
      when = "destroy"
      command = "virsh net-destroy picalc_net && virsh net-undefine picalc_net"
   }
}


# provider doesnt supoort the use of hosts for static users
# resource "libvirt_network" "picalc_network" {
#  name      = "picalc_net"
#  mode      = "nat"
#  addresses = ["192.168.180.0/24"]
#  dhcp {
#    enabled = true
#  }
#
  # mac adress ??
  # hosts = [("192.168.180.0", "00:52:56:22:22:22")]not yet a feature of the provider https://github.com/dmacvicar/terraform-provider-libvirt/issues/565
#  dns {
#    enabled = true
#  }
#
#}

