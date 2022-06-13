# Creación de 4 maquinas virtuales. Se crean a traves de la iteracion count mediante la declaracion en el archivo vars.tf de la variable vm_iteration
# Se utiliza el valor del index para darle un nombre diferente a cada una de las maquinas asi como las ip publica y tarjeta de red.

resource "azurerm_linux_virtual_machine" "eqsVM" {
    #TO-DO hay que hacer tantas maquinas virtuales como iteraciones haga la variable vm_iteration.
    count               = length(var.vm_iteration)
    name                = "eqs-vm-${var.vm_iteration[count.index]}"
    resource_group_name = azurerm_resource_group.rg_eqs.name
    location            = azurerm_resource_group.rg_eqs.location
    size                = var.vm_size
    admin_username      = var.ssh_user
    network_interface_ids = [azurerm_network_interface.eqsNics[count.index].id]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "adminUsername"
        public_key = file(var.public_key_path)
        
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    provisioner "file" {
      source =   "${var.public_key_path}"
      destination = "~/.ssh/authorized_keys"
    }
    user_data = <<HEREDOC
    #cloud-config

    hostname: ${var.vm_iteration[count.index]}.eqs-unir.es
    manage_etc_hosts: True

  HEREDOC
    tags = {
        environment = "CP2"
    }

}