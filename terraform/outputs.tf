# 
data "azurerm_public_ip" "public_ip" {
  count               = length(var.vm_iteration)
  name                = module.network_eqs.my_network[count.index].public_ip_name
  resource_group_name = azurerm_linux_virtual_machine.eqsVM[count.index].resource_group_name
}

#Se realiza una salida de la informacion mas util de cada una de las maquinas, una vez realizado el despliegue
output "instances" {
  value= {
    for k,v in azurerm_linux_virtual_machine.eqsVM: k=>
    {
        name = v.name
        resource_group_name = v.resource_group_name
        nic_name = [module.network_eqs.my_network[k].nic_name]
        private_ip = [module.network_eqs.my_network[k].private_ip]
        public_ip = data.azurerm_public_ip.public_ip[k].ip_address
    }

  }
}