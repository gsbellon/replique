# Rapport zenodo-23685753 — état : publiable

Verdict : **divergent** — portée : **paquet**. (Version précédente : *reproduit*, retiré après la relecture du 2026-11-04 : aucun critère écrit ne permettait de dire acceptables les écarts mesurés sur les fichiers autres que le tableau principal.) La commande unique du README (`python reproduce_all.py`) s'exécute en code 0 en 1 610 s ; les 63 CSV livrés ont chacun un homologue régénéré, mais aucun n'est identique à l'octet et 41 sur 63 ont au moins une cellule différente : 20 394 cellules sur 67 716, écart relatif maximal 2,4·10³ (`compare_csv2.log`). Tous les fichiers SHAP d'XGBoost, `dm_tests.csv`, `dm_vs_naive.csv`, `mcs.csv`, `almon_weights.csv` (MIDAS), `metrics.csv` et `predictions.csv` de `unconditional/extended` diffèrent (Résultats, points 3 à 7) ; p MCS de `combo_trees`, unconditional/core : 0,925 livré, 0,622 régénéré. Les nombres du tableau principal (`metrics_all.csv`) sont dans la borne « au plus 0,025 RMSE » que le README annonce pour les tableaux principaux (XGBoost : 0,02456 au plus, de peu ; `compare_rmse.log`), mais cette borne ne couvre pas les autres fichiers. Le README affirme aussi que les régressions MIDAS se reproduisent « bit à bit » : ce n'est pas ce qui est mesuré (point 7). L'écart est décrit, aucune cause n'est avancée. La portée *paquet* ne dit rien des nombres de l'article, qui n'a pas été lu. Une notification à l'auteur correspondant est préparée (`NOTIFICATION.md`) ; le rapport ne sera publié qu'après le délai de quatorze jours ou la réponse (art. 6, 6 quater).

Couverture : *régénération* (les 63 CSV et les 14 figures livrés sont régénérés et comparés ; les figures seulement à l'octet).

## Paquet

- Zenodo 23685753, « Replication package: Explainable machine-learning nowcasting in small samples » (application à l'inflation énergie-logement en Türkiye), deux auteurs (Yeşilyayla, Hamid), licence MIT (`bin/fiche_zenodo.sh rapports/zenodo-recherche-20261103/recherche.json 23685753`).
- Un fichier, `energy_nowcasting_replication_v1.0.1.zip`, 7 837 952 octets ; MD5 de la fiche (7728203c…) concordant (`telechargement.log`, « OK ») ; 127 fichiers extraits, code 0.
- Données : brutes incluses (BCRT, EIA, EPİAŞ ; fiche et README). Dépendances figées par `requirements.txt` ; durée annoncée : 60-90 min (`readme.log`). Durée mesurée : 1 610 s, soit 27 min (`run-complet.log`, ligne « durée »). Je ne l'explique pas.

## Environnement

- sd-92569, podman sans root. Image `replab-nowcast`, aux versions du `requirements.txt` : Python 3.12.15, numpy 2.5.3, pandas 3.0.6, scipy 1.18.1, scikit-learn 1.9.1, xgboost 3.4.1, lightgbm 4.7.0, shap 0.53.0, arch 8.0.0, matplotlib 3.11.2 (`build2.log`). Première construction en échec (`libgomp.so.1` absente, `build.log`) ; `libgomp1` ajouté au Containerfile.
- Exécution : conteneur `--network none --cap-drop all --security-opt no-new-privileges --read-only --tmpfs /tmp`, seul `run/` en écriture, copie du paquet (original intact dans `pkg/`), borne 5 h (`lance_run.sh`). Lancée détachée par `bin/lance_detache.sh`. Aucun réseau, aucun secret à bord.
- Les CSV sont comparés sur l'hôte par `python3 -I`, qui ne lit que du texte.
- Politique de sortie de l'hôte, relevée le 2026-11-04T20:12Z, donc après l'exécution (`politique_sortie.log`, `sudo nft list table inet replab; sudo nft list chain ip filter ufw-user-output`) : ports 25, 465, 587 refusés, destinations journalisées pour l'utilisateur 1001 à 20 nouvelles connexions par seconde ; compteurs des règles de refus à 0 paquet. Je n'ai pas de relevé daté d'avant l'exécution du 2026-11-03 dans ce dossier ; les rapports zenodo-23804087 et zenodo-23864979 portent la même règle relevée les jours précédents. Le paquet a tourné sans réseau.
- Le « canon » du paquet a été produit sous Windows 11 (README) ; l'exécution ici est sous Linux.

## Commandes

```
bash bin/fiche_zenodo.sh rapports/zenodo-recherche-20261103/recherche.json 23685753
bin/capture.sh rapports/zenodo-23685753/telechargement.log 'sh work/telecharge_extrait.sh'
bash bin/lance_detache.sh work/z23685753 lance_run.sh run.log
bin/capture.sh rapports/zenodo-23685753/run-complet.log 'cat ~/work/z23685753/run.log'
scp rapports/zenodo-23685753/compare.sh rapports/zenodo-23685753/compare_csv.py sd-92569:work/z23685753/
bin/capture.sh rapports/zenodo-23685753/compare.log 'cd ~/work/z23685753 && sh compare.sh'
bin/capture.sh rapports/zenodo-23685753/compare_csv2.log 'cd ~/work/z23685753 && python3 -I compare_csv.py pkg/energy_nowcasting_replication/results run/results'
scp rapports/zenodo-23685753/compare_rmse.py sd-92569:work/z23685753/
bin/capture.sh rapports/zenodo-23685753/compare_rmse.log 'cd ~/work/z23685753 && python3 -I compare_rmse.py pkg/energy_nowcasting_replication/results/evaluation/metrics_all.csv run/results/evaluation/metrics_all.csv'
bin/capture.sh rapports/zenodo-23685753/octets.log 'cd ~/work/z23685753 && cmp pkg/energy_nowcasting_replication/results/robustness/vif.csv run/results/robustness/vif.csv; file …; wc -c …'
bin/capture.sh rapports/zenodo-23685753/crlf.log 'cd ~/work/z23685753 && grep -c -P "\r$" pkg/energy_nowcasting_replication/results/robustness/vif.csv run/results/robustness/vif.csv; wc -l …'
bin/capture.sh rapports/zenodo-23685753/entete.log 'cd ~/work/z23685753 && head -n 4 …/metrics_all.csv run/results/evaluation/metrics_all.csv'
bin/capture.sh rapports/zenodo-23685753/politique_sortie.log 'sudo nft list table inet replab; sudo nft list chain ip filter ufw-user-output'
bin/capture.sh rapports/zenodo-23685753/entete2.log 'cd ~/work/z23685753 && head -n 3 …/hyperparameter_sensitivity.csv …/window_robustness.csv; cut -d, -f1-4 …/window_robustness.csv'
```

## Résultats

1. **Exécution.** `python3 reproduce_all.py` : code 0, 1 610 s, de 20:02:55Z à 20:29:45Z le 2026-11-03 ; 9 tests pytest réussis (`run-complet.log`).
2. **Première comparaison défectueuse.** `compare.log` (premier appel) annonce « CSV livrés : 0 | régénérés : 0 » : mon script ne parcourait pas les sous-dossiers. Défaut de ma comparaison, pas du paquet ; `compare_csv.py` corrigé (parcours récursif), nouvel appel dans `compare_csv2.log`. La partie figures et `diff` de `compare.log` reste valable.
3. **CSV, cellule par cellule** (`compare_csv2.log`) : 63 livrés, 63 régénérés, aucun d'un seul côté. Aucun identique à l'octet. 22 fichiers n'ont aucune cellule différente (Elastic Net : `enet_coef_history`, `enet_selected` ; tous les fichiers `shap_*_lightgbm` ; `family_correlations`, `vif`) ; ils ne sont pas pour autant identiques à l'octet, et seule la cause de `vif.csv` est établie ci-après. Parmi les fichiers en écart figurent aussi `unconditional/extended/metrics.csv` (15 cellules sur 63, écart absolu max 1,7) et `unconditional/extended/predictions.csv` (écart absolu jusqu'à 0,751, relatif 16,3) (`compare_csv2.log`) ; dans `shap_summary_xgboost.csv`, des cellules non numériques (texte) diffèrent aussi (34 et 50 dans les deux cas relus, `compare_csv2.log`). Pour `vif.csv` j'ai établi la cause de la différence d'octets : fins de ligne CRLF (45 lignes) dans le fichier livré, LF dans le régénéré, 2 132 contre 2 087 octets (`octets.log`, `crlf.log`) ; je ne l'ai pas vérifié pour les 21 autres. Les 41 autres fichiers ont au moins une cellule différente ; au total 20 394 cellules sur 67 716, écart absolu maximal 7,67·10⁴, relatif maximal 2,4·10³.
4. **Tableau principal** (`compare_rmse.log`, 32 lignes, RMSE livré / régénéré) : `elasticnet`, `lightgbm`, `seasonal_naive` : écart 0 ; `umidas` ≤ 9,8·10⁻¹⁵ ; `midas_almon` ≤ 1,09·10⁻⁸ ; `xgboost` : 3,3350 / 3,3207 (conditional/core), 3,4302 / 3,4413, 3,3521 / 3,3767, 3,4590 / 3,4439 ; `combo_all` ≤ 0,0074 ; `combo_trees` ≤ 0,0106. Les deux combinaisons contiennent XGBoost ; je n'ai pas vérifié leur définition dans le code.
5. **Fichiers dépendant d'XGBoost.** Tous les `shap_*_xgboost.csv` diffèrent (par exemple `shap_originwise_xgboost.csv` : 4 052 cellules sur 4 365 en conditional/core), alors que les `shap_*_lightgbm.csv` ont zéro cellule différente. Dans `window_robustness.csv` et `hyperparameter_sensitivity.csv`, les lignes lues sont des lignes `xgboost` et `lightgbm` ; je n'ai pas ventilé les 18 et 108 cellules différentes par modèle, mais leur écart absolu maximal est de 0,535 et 0,1. Cela est compatible avec une source unique XGBoost ; je ne l'ai pas établi.
6. **Tests et MCS.** `dm_tests.csv` : 796 cellules sur 2 250 différentes, écart absolu max 1,08 ; `dm_vs_naive.csv` : 156/513, 0,096 ; `mcs.csv` : 69/390, 0,548. Dans le résumé, p de DM-HLN pour XGBoost, unconditional/core : 0,0400 livré, 0,0499 régénéré ; p MCS unconditional/core pour `combo_trees` : 0,925 livré, 0,622 régénéré (`compare.log`, diff de `reproduction_summary.txt`). Aucun p de DM relevé ne change de côté de 0,05 dans la table imprimée ; je n'ai pas contrôlé les 156 cellules une à une.
7. **MIDAS.** Prédictions et métriques à ≤ 1,5·10⁻⁶ ; mais `almon_weights.csv` diffère de façon importante (par exemple 252 cellules sur 679 en conditional/core, écart absolu max 2,02·10⁴). Le README annonce que les régressions MIDAS se reproduisent « bit à bit » entre Windows et Linux : ce n'est pas ce que je mesure (cellules différentes, à ~10⁻⁷ sur les prédictions). Cause non établie (voir Limites).
8. **Figures.** Les 14 PNG régénérés diffèrent des 14 livrés à l'octet (`compare.log`), y compris ceux qui ne dépendent pas d'XGBoost selon leur nom (par exemple `Fig2_enet_family_shares_unconditional_core.png`). Non comparées autrement.
9. **`reproduction_summary.txt` et `environment_report.txt`** diffèrent (horodatage, versions ; `diff` de `compare.log`) ; le résumé du paquet porte des valeurs différentes pour XGBoost et ses combinaisons, identiques pour les autres.
10. **Répétabilité.** Une seule exécution complète ; je ne sais pas si XGBoost est déterministe sur sd-92569 d'une exécution à l'autre.

## Limites

- **Portée.** *Paquet* : les sorties livrées ne sont pas toutes régénérées ; les modèles non arborescents le sont aux arrondis près, le tableau principal d'XGBoost dans la tolérance de 0,025 RMSE que le paquet annonce pour « les tableaux principaux » ; les fichiers SHAP, DM, MCS, MIDAS (poids) et extended diffèrent plus fortement et n'ont pas de borne annoncée. Aucune comparaison avec l'article (non lu).
- **Choix de verdict.** *divergent* : écart mesuré entre fichiers livrés et régénérés, sans critère écrit qui le rende acceptable en dehors du tableau principal, et contraire à l'affirmation « bit à bit » du README pour MIDAS. Aucune intention n'est inférée. Notification préparée (`NOTIFICATION.md`), envoi par le propriétaire.
- **Cause des écarts.** Non établie : plateforme, version de bibliothèque (numpy 2.5.3, pandas 3.0.6 sont plus récents que ceux du canon que je n'ai pas relevés ici) ou autre. Pas d'hypothèse sur autre chose que le calcul.
- **Comparaisons non faites.** Figures sur le contenu ; fins de ligne de 21 CSV ; 156 cellules DM une à une ; durée (27 min contre 60-90).
- **Défaut de la première comparaison** (point 2).
- Les sorties de l'exécution restent sur sd-92569 (`~/work/z23685753/run`, `pkg`) ; seuls les logs sont copiés ici.
