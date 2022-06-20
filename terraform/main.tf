#Provider en el que se indica que el despliegue se realizará en Azure
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.1"
    }
  }
}

#Creacion del grupo de recursos
resource "azurerm_resource_group" "rg_eqs" {
    name     =  "kubet_rg_eqs"
    location = var.location

    tags = {
        environment = var.environment
    }

}

#Creacion de la cuenta de almacenamiento
resource "azurerm_storage_account" "stAccount" {
    name                     = var.storage_account 
    resource_group_name      = azurerm_resource_group.rg_eqs.name
    location                 = azurerm_resource_group.rg_eqs.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = var.environment
    }

}