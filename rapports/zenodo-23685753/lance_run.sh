#!/bin/sh
# Ligne d'appel (depuis le pilote, à la racine du dépôt) — exécution détachée (60-90 min annoncées) :
#   scp rapports/zenodo-23685753/lance_run.sh sd-92569:work/z23685753/
#   bash bin/lance_detache.sh work/z23685753 lance_run.sh run.log
# Suit le README du paquet : `python reproduce_all.py` depuis la racine du projet (une seule commande).
# Le paquet est copié dans run/ (inscriptible) ; l'original reste intact dans pkg/. Image replab-nowcast, sans réseau,
# sans capacité, racine en lecture seule ; borne dure de 5 h (timeout). Le code de sortie est écrit dans run.log.
rm -rf run && mkdir run
cp -a pkg/energy_nowcasting_replication/. run/
date -u +"début %Y-%m-%dT%H:%M:%SZ"
t0=$(date +%s)
podman run --rm --network none --cap-drop all --security-opt no-new-privileges --read-only --tmpfs /tmp \
  -v "$PWD/run:/work:rw" -w /work -e HOME=/tmp -e MPLCONFIGDIR=/tmp -e PYTHONDONTWRITEBYTECODE=1 \
  localhost/replab-nowcast timeout 18000 python3 reproduce_all.py
echo "code python3 reproduce_all.py : $?"
echo "durée (s) : $(( $(date +%s) - t0 ))"
date -u +"fin %Y-%m-%dT%H:%M:%SZ"
