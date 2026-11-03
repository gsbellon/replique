#!/bin/sh
# Ligne d'appel (depuis le pilote, à la racine du dépôt) :
#   scp rapports/zenodo-23685753/lance_build.sh rapports/zenodo-23685753/Containerfile sd-92569:work/z23685753/
#   bin/capture.sh rapports/zenodo-23685753/build.log 'cd ~/work/z23685753 && sh lance_build.sh'      (1re construction : échec libgomp)
#   bin/capture.sh rapports/zenodo-23685753/build2.log 'cd ~/work/z23685753 && sh lance_build.sh'     (2e, avec libgomp1 : build2.log)
# Contexte de construction = build/ (Containerfile seul ; aucun code du paquet).
rm -rf build && mkdir build
cp Containerfile build/
podman build -t replab-nowcast -f build/Containerfile build
echo "code de sortie build : $?"
podman run --rm --network none --cap-drop all --security-opt no-new-privileges --read-only replab-nowcast python3 -c 'import sys,numpy,pandas,scipy,sklearn,xgboost,lightgbm,shap,arch,matplotlib; print(sys.version); print(numpy.__version__, pandas.__version__, scipy.__version__, sklearn.__version__, xgboost.__version__, lightgbm.__version__, shap.__version__, arch.__version__, matplotlib.__version__)'
podman images
