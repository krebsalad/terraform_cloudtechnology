# fill in template to create ubuntu 16.04 vm

module "ubuntu-1604-data" {
  # load template module
  source = "../libvirt_image_template/"
  
  # set data
  pool_name = "ubuntu-pool"
  pool_dir = "/tmp/terraform_libvirt_provider_images/"
  domain_name = "ubuntu-domain"
  image_name = "ubuntu-16.04-amd64.qcow2"
  common_name = "ubuntu-16.04"
  # image_source = "https://cloud-images.ubuntu.com/releases/xenial/release/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  image_source = "/home/terraform/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  user_data_source = "${path.module}/config/user_data.cfg"
  network_config_source = "${path.module}/config/network_config.cfg"
  domain_memory = 512
}
