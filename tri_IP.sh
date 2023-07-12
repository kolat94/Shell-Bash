#!/bin/bash

#
#
#   Mon script pour lister les adresses ip utilisées dans un fichier de zone dns
#

##########################
# Creation des fonctions #
##########################

# Filtre les lignes contenant des adresses IP et les stocke dans un tableau

function tri_fichier() {

        fichier=$1
        lignes=$(cat $1)
        liste=()

for ligne in $lignes;

do

        if [[ $ligne =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then

        liste+=("$ligne")

        fi

done


tri_ip "${liste[@]}"


}



# Trie les adresses IP par ordre croissant

function tri_ip() {

        ips=("$@")

        # Utilisation de l'option -n pour le tri numérique des octets

        liste_ips_triees=($(printf '%s\n' "${ips[@]}" | sort -t '.' -k1,1n -k2,2n -k3,3n -k4,4n))

    afficher_resultat "${liste_ips_triees[@]}"
}


# Affiche les adresses IP triées

function afficher_resultat() {
    local ips_tri=("$@")

    echo -e "Liste des adresses IP utilisées dans le fichier : \n"
    for ip in "${ips_tri[@]}"; do
        echo "$ip"
    done
}

#############
# Programme #
#############

# Vérifie si un fichier a été passé en argument

if [ $# -eq 0 ]; then
    echo "Veuillez spécifier un fichier texte à traiter."
fi

fichier=$1


# Vérifie si le fichier existe

if [ ! -f "$fichier" ]; then
    echo "Le fichier $fichier n'existe pas."
fi

tri_fichier "$fichier"