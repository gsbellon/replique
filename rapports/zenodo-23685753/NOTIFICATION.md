# Notification — zenodo-23685753 (art. 6 et 6 quater)

Brouillon rédigé par le mainteneur le 2026-11-04. Envoi par le propriétaire, depuis l'adresse du projet ; la date d'envoi est consignée au journal et le délai de quatorze jours court à partir d'elle. Le rapport n'a pas encore été repassé par le relecteur dans sa version *divergent* : n'envoyer qu'après sa relecture.

**Destinataire** : auteur correspondant du dépôt Zenodo 23685753 (deux auteurs, Yeşilyayla et Hamid). Son adresse ne figure pas au dossier ; le propriétaire la relève sur la fiche publique https://zenodo.org/records/23685753 ou dans l'article. Le mainteneur n'a contacté personne.

**Objet** : Réexécution du paquet de réplication Zenodo 23685753 — écarts constatés

Bonjour,

Le projet Réplique réexécute des paquets de réplication publics et publie un rapport par paquet. Nous avons réexécuté le vôtre, « Replication package: Explainable machine-learning nowcasting in small samples » (energy_nowcasting_replication_v1.0.1.zip). Avant publication, nous vous communiquons les faits. Vous disposez de quatorze jours à compter de la date de cet envoi pour répondre ; votre réponse, si elle vient, sera jointe au rapport sans modification.

**Ce qui a été fait.** `python reproduce_all.py` (commande du README), dans un conteneur sans réseau, aux versions du `requirements.txt` (Python 3.12.15, numpy 2.5.3, pandas 3.0.6, scipy 1.18.1, scikit-learn 1.9.1, xgboost 3.4.1, lightgbm 4.7.0, shap 0.53.0, arch 8.0.0), sous Linux. Code de sortie 0, 1 610 s, 9 tests pytest réussis (`run-complet.log`). Les 63 CSV de `results/` ont chacun un homologue régénéré, comparés cellule à cellule (`python3 -I compare_csv.py <results du paquet> <results régénérés>`, `compare_csv2.log`).

**Ce qui a été constaté.**
- Sur 67 716 cellules comparées, 20 394 diffèrent ; 41 fichiers sur 63 ont au moins une cellule différente ; écart relatif maximal 2,4·10³ (`compare_csv2.log`).
- Tableau principal `metrics_all.csv` (RMSE) : Elastic Net, LightGBM, benchmark saisonnier naïf identiques ; U-MIDAS ≤ 9,8·10⁻¹⁵ ; MIDAS-Almon ≤ 1,09·10⁻⁸ ; XGBoost jusqu'à 0,02456 (3,3350 livré, 3,3207 régénéré, conditional/core), combinaisons jusqu'à 0,0106 (`compare_rmse.log`, `python3 -I compare_rmse.py <metrics_all livré> <metrics_all régénéré>`). Ces écarts sont dans la borne de 0,025 annoncée par le README.
- Hors tableau principal : tous les `shap_*_xgboost.csv` diffèrent, les `shap_*_lightgbm.csv` non ; `dm_tests.csv` (796 cellules sur 2 250), `dm_vs_naive.csv` (156 sur 513), `mcs.csv` (69 sur 390) ; p MCS de `combo_trees`, unconditional/core : 0,925 livré, 0,622 régénéré ; `unconditional/extended/metrics.csv` (15 sur 63, écart absolu max 1,7) et `predictions.csv` (écart absolu jusqu'à 0,751) ; `almon_weights.csv` (MIDAS, 252 cellules sur 679 en conditional/core, écart absolu max 2,02·10⁴) alors que le README indique que les régressions MIDAS se reproduisent « bit à bit » entre Windows et Linux (prédictions MIDAS à ≤ 1,5·10⁻⁶).
- Les 14 figures PNG régénérées diffèrent à l'octet des figures livrées (`compare.log`).
- `vif.csv` ne diffère que par les fins de ligne (CRLF livré, LF régénéré ; `crlf.log`).

**Ce qui n'est pas établi.** La cause des écarts (plateforme, versions de bibliothèques plus récentes que celles du canon, ou autre) ; si XGBoost est déterministe d'une exécution à l'autre (une seule exécution complète). Le rapport ne compare pas les résultats aux nombres de l'article (portée *paquet*) et ne se prononce pas sur ses conclusions.

Verdict proposé : **divergent**, portée **paquet**. Couverture : *régénération*.

Le rapport complet, avec toutes les commandes et tous les journaux, se trouve dans `rapports/zenodo-23685753/` du dépôt du projet. Si vous disposez d'éléments qui expliquent l'écart (versions, graines, critère de tolérance pour les fichiers SHAP, DM et MCS), nous les joindrons volontiers.

Cordialement,
Réplique
