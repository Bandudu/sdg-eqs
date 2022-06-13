# Creación de la red
resource "azurerm_virtual_network" "eqsNet" {
    name                = var.net_name
    address_space       = var.cidr_gen
    location            = var.location
    resource_group_name = var.resource_group_name

    tags = {
        environment = var.environment
    }
}

# Creación de subred en la que estaran las máquinas. Se crea una máscara /24 debido a que es suficiente para que funcione la practica sin problemas sin realizar subnetting
resource "azurerm_subnet" "eqsSubnet" {
    name                   = var.subnet_group_name
    resource_group_name    = var.resource_group_name
    virtual_network_name   = azurerm_virtual_network.eqsNet.name
    address_prefixes       = var.cidr_subnet

}
#TO-DO COntinuar por aqui

# IP pública
# Se crean 4 ips publicas para asigarlas a cada una de las maquinas.

resource "azurerm_public_ip" "eqsPublicIp" {
  count               = length(var.vm_iteration)
  name                = "vmip-${count.index + 1}"
  location            = azurerm_resource_group.rg_eqs.location
  resource_group_name = azurerm_resource_group.rg_eqs.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}


# Creacion de las tarjetas de red
# Se crean 4 tarjetas que se asignaran a cada una de las maquinas

resource "azurerm_network_interface" "eqsNics" {
  count               = length(var.vm_iteration)
  name                = "vmnic-${count.index + 1}"  
  location            = azurerm_resource_group.rg_eqs.location
  resource_group_name = azurerm_resource_group.rg_eqs.name

    ip_configuration {
    name                           = "eqsipconfiguration${count.index + 1}"
    subnet_id                      = azurerm_subnet.eqsSubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.${10 + count.index}"
    public_ip_address_id           = azurerm_public_ip.eqsPublicIp[count.index].id
  }

    tags = {
        environment = "CP2"
    }

}