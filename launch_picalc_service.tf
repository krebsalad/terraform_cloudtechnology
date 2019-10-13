# launch network 
module "picalc_network_module" {
  source = "./modules/libvirt_picalc_network/"
}

launch picalc servers
module "picalc_service_module" {
  source = "./modules/libvirt_dual_picalc_server/"
}

# don't forget to change ip's to load balance for in config folder of the module
module "loadbalancing_module" {
  source = "./modules/libvirt_load_balancer/"
}
  
