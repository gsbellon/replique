# Rapport zenodo-23439616 — état : brouillon

Verdict proposé par l'auteur : **reproduit** (à confirmer ou bloquer par le relecteur ; seul le relecteur passe à `publiable`).

## Paquet

- Zenodo 23439616, « Constraint-history corrections for nonlinear fractional dynamics: a vesicle relaxation study » (Talbi, Boudjemaa), licence CC-BY-4.0, fichier `paper3_cnsns_supplementary.zip`.
- Source du téléchargement : `https://zenodo.org/api/records/23439616` (métadonnées lues par `curl` sur sd-92569). Somme MD5 annoncée par Zenodo : `f8868393f11a8236b4748f716fb9ee28` ; `md5sum pkg.zip` sur sd-92569 donne `f8868393f11a8236b4748f716fb9ee28` (identique, section `== md5 zip` de `comparaison.log`). sha256 du zip : `eb955a4b14e53455e1453e8e94a955078f10b1538b490ac530d305a57e7ba7bd` (`sha256sum pkg.zip`).
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

- A. mode par défaut (`argv = ['reproduce_results_cnsns.py']`) : code retour 0 ; durée 7,6 s relevée par la session précédente avec `time`, sans que la sortie de `time` ait été conservée. Les trajectoires géométriques viennent des données fournies (vérifiées par somme du solveur par le paquet).
- B. recalcul complet (`argv = [..., '--recompute', '--workers', '6']`) : code retour 0. Recalcule les 29 trajectoires uniformes et 5 graduées. **Durée non mesurée de façon conservée** : la session précédente a rapporté « moins de 10 minutes » sans garder la sortie de `time`, et les horodatages de fichiers actuels (copies du 19:40 CEST) ne permettent pas de la reconstituer. Aucune durée n'est donc affirmée ici ; une prochaine exécution devra la consigner.
- Les sorties standard des deux exécutions (JSON de résultats imprimé) sont dans `run.log` (A) et `run2.log` (B), copiés depuis `~/work/z23439616/` par `scp sd-92569:work/z23439616/run.log .` (idem `run2.log`).

## Résultats

Référence = les trois JSON fournis dans le zip, copiés avant exécution dans `pristine_code/` sur sd-92569 ; obtenus = `run/code/` (A) et `run2/code/` (B). Comparaison nombre à nombre de tous les champs par `compare.py` (versionné ici ; erreur relative |a−b|/|a|, |a−b| si a = 0). Commande qui a produit tout le tableau et les sommes (sortie complète dans `comparaison.log`) :

```
scp compare.py lance_comparaison.sh sd-92569:work/z23439616/
ssh sd-92569 'cd ~/work/z23439616 && sh lance_comparaison.sh'
```

(chaque fichier : `python3 -I compare.py pristine_code/<f> <run|run2>/code/<f>`, voir `lance_comparaison.sh`.)

| Fichier | Champs numériques comparés | Écart relatif max (A) | Écart relatif max (B) |
|---|---|---|---|
| results_cnsns_study.json | 105 | 0,0 | 0,0 |
| results_cnsns_geometry.json | 102 190 | 0,0 | 0,0 |
| results_cnsns_graded.json | 15 580 | 0,0 | 0,0 |

Correction : la première version de ce rapport annonçait 106 champs pour `study` ; le script versionné en compte 105. Le 106ᵉ était vraisemblablement la chaîne de version, comptée à tort. Le chiffre de 105 est celui que la commande ci-dessus produit.

- Seule différence non numérique : `software.python`, « 3.12.3 » (auteurs) contre « 3.12.15 » (ici), dans `study` en A et en B.
- Sommes sha256 complètes (même commande, section `== sha256` de `comparaison.log`) :
  - `pristine_code/results_cnsns_geometry.json` et `run/code/…` : `943f9276b491b9caab2dc2451f6fb2535001718bd9ec29979b2b9681126ac61d` ; `run2/code/…` : `8e8861238235ed7795f8285c39ab5d11b7d06049c3d8b0a6239d0d2fa98d627f` (mêmes nombres, `compare.py` ne voit aucune différence ; la cause, ordre des clés, n'a pas été vérifiée par commande — hypothèse).
  - `results_cnsns_graded.json`, fourni, A et B : `6ebec08ed00bf7b3db5e88cf4a7c7b2c4989c1e0c2b3629a44028d0be6c76605`.
  - `results_cnsns_study.json` fourni : `423841807ac5d4a5ff6dd0e7570e15089aef03c3fcc569914400fe29b4a36887` ; A et B : `f0df58cca4f75004354b8717a22bd051de1fadbf35b0cfa273d5ec8c788cccc5` (la seule différence relevée par `compare.py` est la chaîne de version Python).
- Les six figures PDF et trois fichiers `.tex` de tables ont été générés (`ls article article/figures`).

## Limites

- La comparaison porte sur les JSON fournis par les auteurs, pas sur les nombres imprimés dans l'article, que cette session n'a pas lus : on établit que le paquet régénère ses propres données, pas que l'article les cite fidèlement.
- Les figures n'ont pas été comparées visuellement ni par somme.
- Bit-identité obtenue sur une seule machine, une seule version de Python (3.12.15), pas sur celle des auteurs.
- Les durées de A et B ne sont pas conservées (voir plus haut).
- Les JSON de référence sont ceux du zip tel que copié dans `pristine_code/` avant exécution ; leur copie n'a pas été re-comparée au zip par une commande dans cette session (sha256 identiques à ceux de `pristine.sha256` noté avant l'exécution).
