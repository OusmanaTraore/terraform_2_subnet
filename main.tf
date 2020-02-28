
#créer un resource groupe
resource "azurerm_resource_group" "rg"{
	name= "${var.name}"
	location= "${var.location}"
	tags {
		owner = "${var.owner}"
	}
}
#créer un virtual network
resource "azurerm_virtual_network" "myFirstVnet"{
    name = "${var.name_vnet}"
    address_space = "${var.address_space}"
    location    =   "${var.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
}

#créer un subnet 
resource "azurerm_subnet" "mySubnet1" {
    name="mySubnet1"
    resource_group_name="${azurerm_resource_group.rg.name}"
    virtual_network_name="${azurerm_virtual_network.myFirstVnet.name}"
    address_prefix="10.0.0.0/24"
}

#create Network SecurityGroup
resource "azurerm_network_security_group" "myNsg1"{
    name="myNsg1"
    location="${var.location}"
    resource_group_name="${azurerm_resource_group.rg.name}"

  security_rule{
      name                            ="SSH"
      priority                        =1001
      direction                       ="Inbound"
      access                          ="Allow"
      protocol                        ="Tcp"
      source_port_range               ="*"
      destination_port_range          ="22"
      source_address_prefix           ="*"
      destination_address_prefix      ="*"
  }
  security_rule{
      name                            ="HTTP"
      priority                        =1002
      direction                       ="Inbound"
      access                          ="Allow"
      protocol                        ="Tcp"
      source_port_range               ="*"
      destination_port_range          ="80"
      source_address_prefix           ="*"
      destination_address_prefix      ="*"
  }
}

#create Ip Public
resource "azurerm_public_ip" "myPubIp1" {
    name="myPubIp1"
    location="${var.location}"
    resource_group_name="${azurerm_resource_group.rg.name}"
    allocation_method="${var.allocation_method}"
}

#create network Interface 
resource "azurerm_network_interface" "NIC1" {
  name="NIC1"
  location="${var.location}"
  resource_group_name="${azurerm_resource_group.rg.name}"
  network_security_group_id="${azurerm_network_security_group.myNsg1.id}"
  ip_configuration{
      name="${var.nameNICConfig1}"
      subnet_id="${azurerm_subnet.mySubnet1.id}"
      private_ip_address_allocation="${var.allocation_method}"
      public_ip_address_id="${azurerm_public_ip.myPubIp1.id}"
  }
}
#create virtual_machine 
resource "azurerm_virtual_machine" "MyVm1" {
    name="Vm1"
    location="${var.location}"
    resource_group_name="${azurerm_resource_group.rg.name}"
    network_interface_ids=["${azurerm_network_interface.NIC1.id}"]
    vm_size="${var.vmSize}"

    storage_os_disk{
        name="Disk1"
        caching="ReadWrite"
        create_option="FromImage"
        managed_disk_type="Standard_LRS"
    }
    storage_image_reference{
        publisher="OpenLogic"
        offer="CentOS"
        sku="7.6"
        version="latest"
    }
    os_profile{
        computer_name="vm1"
        admin_username="yous"
    }

    os_profile_linux_config{
        disable_password_authentication= true
        
        ssh_keys{
            path="/home/yous/.ssh/authorized_keys"
            key_data="${var.key_data}"
        }
    }

}

resource "azurerm_subnet" "mySubnet2" {
    name="mySubnet2"
    resource_group_name="${azurerm_resource_group.rg.name}"
    virtual_network_name="${azurerm_virtual_network.myFirstVnet.name}"
    address_prefix="10.0.1.0/24"
}
resource "azurerm_network_security_group" "myNsg2"{
    name="myNsg2"
    location="${var.location}"
    resource_group_name="${azurerm_resource_group.rg.name}"

  security_rule{
      name                            ="SSH"
      priority                        =1001
      direction                       ="Inbound"
      access                          ="Allow"
      protocol                        ="Tcp"
      source_port_range               ="*"
      destination_port_range          ="22"
      source_address_prefix           ="*"
      destination_address_prefix      ="*"
  }
  security_rule{
      name                            ="HTTP"
      priority                        =1002
      direction                       ="Inbound"
      access                          ="Allow"
      protocol                        ="Tcp"
      source_port_range               ="*"
      destination_port_range          ="80"
      source_address_prefix           ="*"
      destination_address_prefix      ="*"
  }
}
resource "azurerm_public_ip" "myPubIp2" {
    name="myPubIp2"
    location="${var.location}"
    resource_group_name="${azurerm_resource_group.rg.name}"
    allocation_method="${var.allocation_method}"
}
resource "azurerm_network_interface" "NIC2" {
  name="NIC2"
  location="${var.location}"
  resource_group_name="${azurerm_resource_group.rg.name}"
  network_security_group_id="${azurerm_network_security_group.myNsg2.id}"
  ip_configuration{
      name="${var.nameNICConfig2}"
      subnet_id="${azurerm_subnet.mySubnet2.id}"
      private_ip_address_allocation="${var.allocation_method}"
      public_ip_address_id="${azurerm_public_ip.myPubIp2.id}"
  }
}
resource "azurerm_virtual_machine" "MyVm2" {
    name="Vm2"
    location="${var.location}"
    resource_group_name="${azurerm_resource_group.rg.name}"
    network_interface_ids=["${azurerm_network_interface.NIC2.id}"]
    vm_size="${var.vmSize}"

    storage_os_disk{
        name="Disk2"
        caching="ReadWrite"
        create_option="FromImage"
        managed_disk_type="Standard_LRS"
    }
    storage_image_reference{
        publisher="OpenLogic"
        offer="CentOS"
        sku="7.6"
        version="latest"
    }
    os_profile{
        computer_name="vm2"
        admin_username="Ousmana"
    }

    os_profile_linux_config{
        disable_password_authentication= true
        
        ssh_keys{
            path="/home/Ousmana/.ssh/authorized_keys"
            key_data="${var.key_data}"
        }
    }

}








