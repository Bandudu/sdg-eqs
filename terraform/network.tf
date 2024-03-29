module "network_eqs" {
    net_name = "kubernetesnet"
    source = "./modules/network"
    cidr_gen = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg_eqs.location
    resource_group_name = azurerm_resource_group.rg_eqs.name
    environment = var.environment
    
    #Subnets
    subnet_group_name = "subneteqs"
    cidr_subnet = ["10.0.1.0/24"]
    vm_iteration = var.vm_iteration
}
