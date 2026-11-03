#!/bin/sh
# Ligne d'appel (depuis le pilote, à la racine du dépôt) :
#   scp rapports/zenodo-23685753/telecharge_extrait.sh sd-92569:work/
#   bin/capture.sh rapports/zenodo-23685753/telechargement.log 'sh work/telecharge_extrait.sh'
# Télécharge sur l'hôte (curl seulement) l'archive depuis Zenodo, vérifie le MD5 de la fiche
# (recherche.json de rapports/zenodo-recherche-20261103), extrait dans un dossier vide pkg/ avec python -I
# (aucun code du paquet n'est exécuté).
F=energy_nowcasting_replication_v1.0.1.zip
B=https://zenodo.org/api/records/23685753/files
rm -rf work/z23685753 && mkdir -p work/z23685753/dl work/z23685753/pkg
cd work/z23685753/dl || exit 1
curl -sS -f --retry 3 -m 300 -o "$F" "$B/$F/content" || { echo "ECHEC curl : $?"; exit 1; }
echo "7728203ce3210c20ec2bbacb7d7f3571  $F" > MD5.txt
md5sum -c MD5.txt || { echo "MD5 DIFFERENT"; exit 1; }
cd ../pkg || exit 1
python3 -I -c "import sys, zipfile; zipfile.ZipFile(sys.argv[1]).extractall('.')" "../dl/$F"
echo "code extraction : $?"
find . -type f | wc -l
find . -maxdepth 3 -type f -size -200k -not -name '*.csv'
