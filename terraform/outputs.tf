# #Se realiza una salida de la informacion mas util de cada una de las maquinas, una vez realizado el despliegue
output "instances" {
  value= {
    for k,v in azurerm_linux_virtual_machine.eqsVM: k=>
    {
        name = v.name
        resource_group_name = v.resource_group_name
        nic_name = [module.network_eqs.my_network[k].nic_name]
        private_ip = [module.network_eqs.my_network[k].private_ip]
        public_ip = [module.network_eqs.my_network[k].public_ip]
    }

  }
}