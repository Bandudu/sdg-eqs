# Creación de la red
resource "azurerm_virtual_network" "eqsNet" {
    name                = "kubernetesnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg_eqs.location
    resource_group_name = azurerm_resource_group.rg_eqs.name

    tags = {
        environment = "Testing"
    }
}

# Creación de subred en la que estaran las máquinas. Se crea una máscara /24 debido a que es suficiente para que funcione la practica sin problemas sin realizar subnetting
resource "azurerm_subnet" "eqsSubnet" {
    name                   = "subneteqs"
    resource_group_name    = azurerm_resource_group.rg_eqs.name
    virtual_network_name   = azurerm_virtual_network.eqsNet.name
    address_prefixes       = ["10.0.1.0/24"]

}


# Creación de subred en la que estaran las máquinas. Se crea una máscara /24 debido a que es suficiente para que funcione la practica sin problemas sin realizar subnetting
resource "azurerm_subnet" "eqsSubnet2" {
    name                   = "subneteqs2"
    resource_group_name    = azurerm_resource_group.rg_eqs.name
    virtual_network_name   = azurerm_virtual_network.eqsNet.name
    address_prefixes       = ["10.0.2.0/24"]

}

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
        environment = "Testing"
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
        environment = "Testing"
    }

}