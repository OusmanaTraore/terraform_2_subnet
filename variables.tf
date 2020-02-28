variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}

variable "tenant_id" {}
variable "version" {}

variable "name" {}
variable "location" {}
variable "owner" {}

variable "name_vnet" {}
variable "address_space" {
    type ="list"
}
variable "name_subnet" {}
#variable "address_prefix" {}
#variable "nameNsg1" {}
#variable "nameNsg2" {}
variable "nameIpPub" {}
variable "allocation_method" {}
variable "nameNIC1" {}
variable "nameNIC2" {}
 
variable "nameNICConfig1" {}
variable "nameNICConfig2" {}

variable "vmSize" {}

variable "nameVm" {}
variable "key_data" {}






















