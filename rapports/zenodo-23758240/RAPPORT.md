# Rapport zenodo-23758240 — état : brouillon

Verdict proposé : **reproduit** — portée : **paquet**. Les trois commandes de la section « Reproduce » du README (`run_experiments.py`, `analyse.py`, `figures.py`) s'exécutent jusqu'au bout, code 0 (`run.log`). Sur les 129 747 cellules des cinq CSV de `results/`, aucune cellule non numérique ne diffère et 2 344 cellules numériques diffèrent à l'octet ; 2 342 d'entre elles par un écart relatif d'au plus 10⁻⁹ (dont une, dans `paired_vs_reactive.csv`, entre 10⁻¹² et 10⁻⁹ ; toutes les autres à 10⁻¹² ou moins, et à 4,72·10⁻¹³ ou moins dans les quatre autres fichiers), **deux** par plus que 10⁻⁹, dans une même ligne de `paired_vs_reactive.csv` : `wins_minus_losses` 0,25 livré contre 0,3 régénéré, `p_value` 0,15063 contre 0,15365 (voir Résultats, point 4). La portée *paquet* ne dit rien des nombres de l'article, qui n'a pas été lu (art. 6 ter).

## Paquet

- Zenodo 23758240, « When Does Prediction Pay Off? Replication Package for Predictive versus Reactive Autoscaling under Controlled Burst Intensity and Provisioning Delay », publié le 2026-10-29, auteurs Hashim M., Moiz Abdul, Zulkifl Hassan (University of Central Punjab), type logiciel, accès ouvert, licence MIT. Fiche : `bin/capture.sh rapports/zenodo-23758240/fiche_zenodo.json 'curl -s -m 60 https://zenodo.org/api/records/23758240'`.
- Un fichier, `zenodo_code_package.zip`, 1 565 839 octets ; MD5 de la fiche concordant avec le fichier téléchargé (`telechargement.log`, ligne « OK ») ; 27 fichiers extraits (`telechargement.log`, `find . -type f | wc -l`), code d'extraction 0.
- Données : la trace de charge (requêtes Wikipédia par seconde) **n'est pas dans le paquet**. Le README (`readme.log`) demande de la prendre dans le dépôt public GitHub `deib-polimi/RAS` (`generators/wiki.1190153705.csv`), par `git clone --depth 1`. Accès public direct, sans inscription ni formulaire (art. 1) : je l'ai récupérée par `curl` seul, même dépôt et même chemin (`telecharge_trace.sh`, `telechargement_trace.log` : code 0, 1 439 950 octets, 360 101 lignes, SHA-256 `01e5b8d4…1bec8`). Je n'ai pas cloné le dépôt ni exécuté quoi que ce soit venant de lui. Le paquet ne fournit pas d'empreinte de cette trace : rien ne permet de dire qu'elle est identique à celle des auteurs, hors la concordance des résultats ci-dessous.
- Le README annonce un temps d'environ une minute sur 2 cœurs et ne fige aucune version : `requirements.txt` donne seulement des bornes basses (numpy ≥ 1.24, scipy ≥ 1.10, pandas ≥ 2.0, matplotlib ≥ 3.7).

## Environnement

- sd-92569, podman sans root. Image `replab-autoscaling` construite (réseau : PyPI, construction seulement) depuis `docker.io/library/python:3.12-slim` avec le `requirements.txt` du paquet (`Containerfile`, `lance_build.sh`, `build.log`). Versions mesurées (`build.log`) : Python 3.12.15, numpy 2.5.4, scipy 1.18.1, pandas 3.1.0, matplotlib 3.11.2. Ce sont les versions les plus récentes disponibles le jour de la construction ; les auteurs n'indiquent pas les leurs.
- Archive et trace manipulées sur l'hôte uniquement par `curl`, `md5sum`, `python3 -I` (`zipfile.extractall`) ; aucun code du paquet n'a tourné sur l'hôte.
- Politique de sortie de l'hôte vérifiée avant le téléchargement : ports 25, 465, 587 refusés, destinations journalisées pour l'utilisateur 1001 (`politique_sortie.log`, `sudo nft list ruleset`).
- Exécution : conteneur `--network none --cap-drop all --security-opt no-new-privileges --read-only --tmpfs /tmp`, seul `run/` monté en écriture (copie du paquet, avec la trace en `data/wiki.csv` ; l'original extrait reste intact dans `pkg/`) (`lance_run.sh`, `run.log`). Aucun réseau pendant l'exécution, aucun secret à bord.

## Commandes

```
bin/capture.sh rapports/zenodo-23758240/fiche_zenodo.json 'curl -s -m 60 https://zenodo.org/api/records/23758240'
scp rapports/zenodo-23758240/telecharge_extrait.sh sd-92569:work/
bin/capture.sh rapports/zenodo-23758240/telechargement.log 'sh work/telecharge_extrait.sh'
bin/capture.sh rapports/zenodo-23758240/readme.log 'cat work/z23758240/pkg/autoscaling-sensitivity-study/README.md work/z23758240/pkg/autoscaling-sensitivity-study/requirements.txt'
bin/capture.sh rapports/zenodo-23758240/politique_sortie.log 'sudo nft list ruleset'
scp rapports/zenodo-23758240/telecharge_trace.sh sd-92569:work/z23758240/
bin/capture.sh rapports/zenodo-23758240/telechargement_trace.log 'cd ~/work/z23758240 && sh telecharge_trace.sh'
scp rapports/zenodo-23758240/lance_build.sh rapports/zenodo-23758240/Containerfile sd-92569:work/z23758240/
bin/capture.sh rapports/zenodo-23758240/build.log 'cd ~/work/z23758240 && sh lance_build.sh'
scp rapports/zenodo-23758240/lance_run.sh sd-92569:work/z23758240/
bin/capture.sh rapports/zenodo-23758240/run.log 'cd ~/work/z23758240 && sh lance_run.sh'
scp rapports/zenodo-23758240/compare.sh sd-92569:work/z23758240/
bin/capture.sh rapports/zenodo-23758240/comparaison_octets.log 'cd ~/work/z23758240 && sh compare.sh'
scp rapports/zenodo-23758240/compare_csv.py rapports/zenodo-23758240/lance_compare_csv.sh sd-92569:work/z23758240/
bin/capture.sh rapports/zenodo-23758240/comparaison_csv.log 'cd ~/work/z23758240 && sh lance_compare_csv.sh'
bin/capture.sh rapports/zenodo-23758240/ligne77.log 'cd ~/work/z23758240 && sed -n 77p pkg/autoscaling-sensitivity-study/results/paired_vs_reactive.csv && sed -n 77p run/results/paired_vs_reactive.csv'
```

`ligne76.log` est un premier relevé, une ligne trop tôt (l'index du script compte à partir de l'en-tête à 0) ; aucun nombre du rapport n'en dépend.

## Résultats

1. **Exécution.** `run_experiments.py` : « 7600 runs in 66s », code 0 ; `analyse.py` code 0 ; `figures.py` : « figures done », code 0 ; de 20:02:10Z à 20:03:22Z, soit 72 s (`run.log`). Le nombre de simulations (7 600) est celui que la fiche Zenodo annonce.
2. **Calibration.** Imprimée par le script : `holt_alpha` 0,2, `holt_beta` 0,1, `lr_window` 40, MAE 7,0698 (Holt) et 6,7098 (régression) (`run.log`). `config_used.json` et `fig5_correlation.json` sont **identiques à l'octet** au fichier livré (`comparaison_octets.log`).
3. **Fichiers de résultats.** Sur les 7 fichiers de `results/`, 2 sont identiques à l'octet (point 2) et 5 CSV diffèrent à l'octet (`comparaison_octets.log`) ; les en-têtes et le nombre de lignes sont identiques pour les cinq (5, 5, 286, 7 601, 381) (`comparaison_csv.log`). Cellule par cellule (`comparaison_csv.log`) : 129 747 cellules au total (36 + 36 + 3 135 + 121 600 + 4 940), **0** cellule non numérique différente, **2 344** cellules numériques différentes à l'octet (11 + 9 + 801 + 566 + 957). Plus grands écarts relatifs par fichier : `overall_means_bursty` 6,27·10⁻¹⁶, `overall_means_control` 1,17·10⁻¹⁴, `raw_results` 1,31·10⁻¹⁵, `summary_medians` 4,72·10⁻¹³, `paired_vs_reactive` 1,67·10⁻¹ (point 4). Les 7 600 lignes de `raw_results.csv` sont donc retrouvées, au dernier chiffre flottant près (566 cellules sur 121 600 ; les cinq exemples imprimés sont dans la colonne `forecast_mae`, je n'ai pas relevé la liste complète des colonnes touchées).
4. **L'écart qui dépasse l'arrondi.** Dans `paired_vs_reactive.csv`, une ligne (magnitude 2, durée 600, rampe 10, délai 0, politique `pred_holt`) diffère par deux colonnes : `wins_minus_losses` **0,25** livré, **0,3** régénéré ; `p_value` **0,15063055879143034** livré, **0,15364646911621094** régénéré (`ligne77.log`, `comparaison_csv.log`). Les autres colonnes de la ligne s'accordent à 10⁻¹² près en relatif. Ce sont les deux seules cellules des cinq CSV au-dessus de 10⁻⁹ en relatif (`comparaison_csv.log`, lignes « ÉCART > 1e-9 »). Les deux valeurs de `p_value` sont supérieures à 0,05. Je ne l'ai rattaché à aucune cause (versions de bibliothèques, méthode de calcul de la statistique, égalité numérique au seuil d'un appariement) : je n'ai pas lu `analyse.py` pour cela, et une seule exécution a eu lieu.
5. **Figures.** `figures.py` s'exécute (code 0) ; les fichiers de `figures/` n'ont pas été comparés à ceux du paquet.

## Limites

- **Portée.** *Paquet* : les fichiers de résultats du paquet sont régénérés par son code (7 600 simulations, 2 fichiers identiques à l'octet, 5 CSV égaux aux arrondis près hors une ligne, point 4). Aucune comparaison avec l'article (non inclus, non lu).
- **Hésitation de verdict, à trancher par le relecteur.** Le point 4 est un écart mesuré, non de l'arrondi, sur une ligne de statistique appariée sur 285 ; j'ai retenu *reproduit* parce que le reste des 129 747 cellules est retrouvé et que le simulateur lui-même (`raw_results.csv`) l'est au 10⁻¹⁵ ; *divergent* décrirait aussi cette ligne et imposerait la notification de l'art. 6. Je n'ai rien notifié.
- **Trace de données.** Prise sur GitHub (branche par défaut, `HEAD`, au 2026-10-31), non sur une version figée par le paquet ; pas d'empreinte livrée.
- **Environnement.** Bibliothèques plus récentes que celles des auteurs, probablement (versions non publiées) ; pandas passe en 3.x. Une seule exécution : la répétabilité n'est pas mesurée ; le paquet annonce des exécutions déterministes (README).
- **Contenu non examiné.** Je n'ai pas lu les cinq scripts `src/` ni jugé la validité scientifique du simulateur, des tests de Wilcoxon ni des figures.
- Les sorties de l'exécution restent sur sd-92569 (`~/work/z23758240/run`, `pkg`, `trace`) ; seuls les logs de comparaison sont copiés ici.
- Aucun auteur n'est notifié : le verdict proposé n'est pas *divergent* (art. 6).
