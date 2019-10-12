

module "ubuntu-18-server-1" {
  # load template module
  source = "../libvirt_image_template/"

  # set data
  pool_name = "ubuntu-pool-1"
  pool_dir = "/tmp/terraform_libvirt_provider_images_1/"
  domain_name = "ubuntu-picalcserver-1"
  image_name = "ubuntu-18-s1-amd64.qcow2"
  common_name = "ubuntu-18-s1"
  # image_source = "https://cloud-images.ubuntu.com/releases/xenial/release/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  image_source = "${path.module}/../../downloads/bionic-server-cloudimg-amd64.img"
  user_data_source = "${path.module}/config/user_data.cfg"
  network_config_source = "${path.module}/config/network_config_1.cfg"
  domain_memory = 512
}

module "ubuntu-18-server-2" {
  # load template module
  source = "../libvirt_image_template/"

  # set data
  pool_name = "ubuntu-pool-2"
  pool_dir = "/tmp/terraform_libvirt_provider_images_2/"
  domain_name = "ubuntu-picalcserver-2"
  image_name = "ubuntu-18-s2-amd64.qcow2"
  common_name = "ubuntu-18-s2"
  # image_source = "https://cloud-images.ubuntu.com/releases/xenial/release/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  image_source = "${path.module}/../../downloads/bionic-server-cloudimg-amd64.img"
  user_data_source = "${path.module}/config/user_data.cfg"
  network_config_source = "${path.module}/config/network_config_2.cfg"
  domain_memory = 512
}

