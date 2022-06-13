# Creacion del Security group
# Se habilita el acceso por ssh abriendo el puerto 22 con protocolo tcp

resource "azurerm_network_security_group" "eqsSecGroup" {
    name                = "sshtraffic"
    location            = azurerm_resource_group.rg_eqs.location
    resource_group_name = azurerm_resource_group.rg_eqs.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}

# Vinculacion del security group al interfaz de red

resource "azurerm_network_interface_security_group_association" "eqsSecGroupAssociation1" {
    count                     = length(var.vm_iteration)
    network_interface_id      = azurerm_network_interface.eqsNics[count.index].id
    network_security_group_id = azurerm_network_security_group.eqsSecGroup.id

}
