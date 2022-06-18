# #Se realiza una salida de la informacion mas util de cada una de las maquinas, una vez realizado el despliegue
# data "azurerm_public_ip" "public_ip" {
#   count               = length(var.vm_iteration)
#   name                = azurerm_public_ip.eqsPublicIp[count.index].name  
#   resource_group_name = azurerm_linux_virtual_machine.eqsVM[count.index].resource_group_name
# }


# output "instances" {
#   value= {
#     for k,v in azurerm_linux_virtual_machine.eqsVM: k=>
#     {
#         name = v.name
#         resource_group_name = v.resource_group_name
#         nic_name = azurerm_network_interface.eqsNics[k].name
#         private_ip = azurerm_network_interface.eqsNics[k].private_ip_address
#         public_ip = data.azurerm_public_ip.public_ip[k].ip_address
#     }

#   }
# }