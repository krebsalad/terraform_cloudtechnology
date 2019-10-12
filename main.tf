# launch picalc servers
module "picalc_service_module" {
  source = "./modules/ibvirt_dual_picalc_server/"
}

# don't forget to change ip's to load balance for in config folder of the module
module "loadbalancing_module" {
  source = "./modules/ibvirt_load_balancer/"
}
  
