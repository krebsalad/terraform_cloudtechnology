

module "ubuntu-18-load-balancer" {
  # load template module
  source = "../libvirt_image_template/"

  # set data
  pool_name = "ubuntu-pool-lb"
  pool_dir = "/tmp/terraform_libvirt_provider_images_lb/"
  domain_name = "ubuntu-loadbalancer"
  image_name = "ubuntu-18-lb-amd64.qcow2"
  common_name = "ubuntu-18-lb"
  # image_source = "https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img"
  image_source = "${path.module}/../../downloads/bionic-server-cloudimg-amd64.img"
  user_data_source = "${path.module}/config/user_data.cfg"
  network_config_source = "${path.module}/config/network_config.cfg"
  domain_memory = 512
  network_name = "picalc_net"
  ip_addr = "192.168.180.102"
}
