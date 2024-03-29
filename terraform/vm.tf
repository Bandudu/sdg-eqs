# Creación de maquinas virtuales. Se crean a traves de la iteracion count mediante la declaracion en el archivo vars.tf de la variable vm_iteration
# Se utiliza el valor del index para darle un nombre diferente a cada una de las maquinas asi como las ip publica y tarjeta de red.

resource "azurerm_linux_virtual_machine" "eqsVM" {
    #TO-DO hay que hacer tantas maquinas virtuales como iteraciones haga la variable vm_iteration.
    count               = length(var.vm_iteration)
    name                = "eqs-vm-${var.vm_iteration[count.index]}"
    resource_group_name = azurerm_resource_group.rg_eqs.name
    location            = azurerm_resource_group.rg_eqs.location
    size                = var.vm_size
    admin_username      = var.ssh_user
    network_interface_ids = [module.network_eqs.my_network[count.index].id_nic]
    disable_password_authentication = true
    
    admin_ssh_key {
        username   = "adminUsername"
        public_key = file(var.public_key_path)
        
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-focal"
        sku       = "20_04-lts"
        version   = "20.04.202004230"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    tags = {
        environment = var.environment
    }

}