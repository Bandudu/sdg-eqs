#Se realiza una salida de la informacion mas util de cada una de las maquinas, una vez realizado el despliegue
data "azurerm_public_ip" "public_ip" {
  count               = length(var.vm_iteration)
  name                = azurerm_public_ip.eqsPublicIp[count.index].name
  resource_group_name = azurerm_network_interface.eqsNics[count.index].resource_group_name
}

data "azurerm_network_interface" "nicsEqs" {
  count               = length(var.vm_iteration)
  resource_group_name = azurerm_network_interface.eqsNics[count.index].resource_group_name
  name                = azurerm_network_interface.eqsNics[count.index].name
}

output "my_network" {
  value= {
    for k,v in azurerm_network_interface.eqsNics: k=>
    {
        name = v.name
        resource_group_name = v.resource_group_name
        nic_name = azurerm_network_interface.eqsNics[k].name
        id_nic = data.azurerm_network_interface.nicsEqs[k].id
        private_ip = azurerm_network_interface.eqsNics[k].private_ip_address
        public_ip = data.azurerm_public_ip.public_ip[k].ip_address
    }

  }
}
