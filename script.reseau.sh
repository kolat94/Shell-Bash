#!/bin/bash

echo -n "voulez vous configurer votre carte en (s)tatique ou (d)hcp ?: "
read mode

if [[ $mode == "d" ]]; then {
	sed -i "\%ipv4%,+2 s/manual/auto/;\%ipv4%,+2 {/address1/d}" /etc/NetworkManager/system-connections/enp0s3.nmconnection
}
elif [[ $mode == "s" ]]; then {
	echo -n "Veuillez entrer l'addresse ip: "
	read ip
	echo -n "Veuillez entrer le cidr à utiliser: "
	read cidr
	echo -n "Veuillez entrer l'addresse de passerelle à utiliser: "
	read gw
	sed -i "\%ipv4%,+2 s/auto/manual/;\%ipv4%,+2 {/address1/d};\%ipv4% a address1=$ip\/$cidr,$gw/" /etc/NetworkManager/system-connections/enp0s3.nmconnection

}
fi
ip address flush dev enp0s3
systemctl restart NetworkManager

