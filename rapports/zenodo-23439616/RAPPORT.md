# Rapport zenodo-23439616 — état : brouillon

Verdict proposé par l'auteur : **reproduit** (à confirmer ou bloquer par le relecteur ; seul le relecteur passe à `publiable`).

## Paquet

- Zenodo 23439616, « Constraint-history corrections for nonlinear fractional dynamics: a vesicle relaxation study » (Talbi, Boudjemaa), licence CC-BY-4.0, fichier `paper3_cnsns_supplementary.zip`.
- Source du téléchargement : `https://zenodo.org/api/records/23439616` (métadonnées lues par `curl` sur sd-92569). Somme MD5 annoncée par Zenodo : `f8868393f11a8236b4748f716fb9ee28`. La somme du zip téléchargé n'a pas été comparée à celle-ci (écart de méthode, voir limites) ; sha256 du zip : `eb955a4b14e53455e1453e8e94a955078f10b1538b490ac530d305a57e7ba7bd` (`sha256sum pkg.zip`).
- Contenu : sources Python, trois fichiers JSON de résultats ; aucune donnée externe (selon le README du paquet).

## Environnement reconstruit

- Hôte : sd-92569, utilisateur `replab` (podman sans root 5.4.2). Image `docker.io/library/python:3.12-slim`, digest `sha256:a6e34c598f2467ed0e9a8d349809fcd8b5c603269512df273a0bb1784edc11b1` (`podman images --format "{{.Repository}}:{{.Tag}} {{.Digest}}"`). Python 3.12.15 dans l'image.
- Dépendances demandées par le paquet : NumPy 2.5.1, Matplotlib 3.11.1. Installées depuis PyPI (dépôt de paquets nommé ici) dans une étape avec réseau, sans exécution de code du paquet :
  `podman run --rm --cap-drop all --security-opt no-new-privileges -v $PWD/deps:/deps:rw python:3.12-slim pip install --no-cache-dir --only-binary :all: --target /deps numpy==2.5.1 matplotlib==3.11.1`
- Exécution du code du paquet : `--network none --cap-drop all --security-opt no-new-privileges --read-only --tmpfs /tmp`, dépendances montées en lecture seule, copie de travail du paquet seule en écriture (`bin/sandbox-args.txt`).

## Commandes d'exécution

Les deux sont de la forme (répertoire `run` ou `run2` copie neuve du paquet extrait) :

```
podman run --rm --network none --cap-drop all --security-opt no-new-privileges --read-only --tmpfs /tmp -e HOME=/tmp \
  -v $PWD/deps:/deps:ro -v $PWD/<run>:/pkg:rw -w /pkg docker.io/library/python:3.12-slim \
  python -I -c "import sys,runpy;sys.path.insert(0,'/deps');sys.argv=[<argv>];runpy.run_path('/pkg/reproduce_results_cnsns.py',run_name='__main__')"
```

- A. mode par défaut (`argv = ['reproduce_results_cnsns.py']`) : code retour 0, 7,6 s (`time`). Les trajectoires géométriques viennent des données fournies (vérifiées par somme du solveur par le paquet).
- B. recalcul complet (`argv = [..., '--recompute', '--workers', '6']`) : code retour 0, un peu moins de 10 minutes. Recalcule les 29 trajectoires uniformes et 5 graduées.

## Résultats

Référence = les trois JSON fournis dans le zip (`sha256sum` sauvegardé avant exécution) ; comparaison nombre à nombre de tous les champs (script Python de comparaison récursive, erreur relative |a−b|/|a|) :

| Fichier | Champs numériques comparés | Écart relatif max (A) | Écart relatif max (B) |
|---|---|---|---|
| results_cnsns_study.json | 106 | 0,0 | 0,0 |
| results_cnsns_geometry.json | 102 190 | 0,0 | 0,0 |
| results_cnsns_graded.json | 15 580 | 0,0 | 0,0 |

- Seul champ non numérique différent : `software.python`, « 3.12.3 » (auteurs) contre « 3.12.15 » (ici).
- Sommes sha256 : `results_cnsns_graded.json` identique (`6ebec08e…`) dans A et B ; `results_cnsns_study.json` diffère à cause de la seule chaîne de version Python (`423841807…` fourni, `f0df58cc…` obtenu) ; `results_cnsns_geometry.json` en B (`8e886123…` contre `943f9276…`) diffère par l'ordre des clés (calcul parallèle), tous les nombres étant identiques.
- Les six figures PDF et trois fichiers `.tex` de tables ont été générés (`ls article article/figures`).

## Limites

- La comparaison porte sur les JSON fournis par les auteurs, pas sur les nombres imprimés dans l'article, que cette session n'a pas lus : on établit que le paquet régénère ses propres données, pas que l'article les cite fidèlement.
- Les figures n'ont pas été comparées visuellement ni par somme.
- La somme MD5 Zenodo n'a pas été recalculée sur le zip.
- Bit-identité obtenue sur une seule machine, une seule version de Python (3.12.15), pas sur celle des auteurs.
- Journaux bruts des exécutions : conservés sur sd-92569 dans `~/work/z23439616/run.log` et `run2.log` (non copiés dans le dépôt, la copie ayant été refusée par le mode d'autorisation de la session).
