#Creacion de una variable en la que declarar el tipo de maquina que queramos crear, por defecto se crea la minima con la que el servicio será funcional
variable "vm_size" {
  type = string
  description = "Tamaño de la máquina virtual"
  default = "Standard_B2s" # 2CPU, 4Gb RAM
}
# Creacion de una variable en por la que se iterará el número de veces necesario para la creacion de maquinas.
variable "vm_iteration" {
  type = list(string)
  description = "Maquinas virutales"
  default = [ "master", "worker1"]
  #default = [ "master", "worker1", "worker2", "nfs"]
}