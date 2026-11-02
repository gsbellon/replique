# Notification — zenodo-23585246 (art. 6 et 6 quater)

Brouillon rédigé par le mainteneur le 2026-11-02. Envoi par le propriétaire, depuis l'adresse du projet ; la date d'envoi est consignée au journal et le délai de quatorze jours court à partir d'elle.

**Destinataire** : auteur correspondant du dépôt Zenodo 23585246. Son adresse ne figure pas au dossier (`fichiers.json` ne donne que la liste des fichiers) ; le propriétaire la relève sur la fiche publique https://zenodo.org/records/23585246 ou dans l'article. Le mainteneur n'a contacté personne.

**Objet** : Réexécution du paquet de réplication Zenodo 23585246 — écarts constatés

Bonjour,

Le projet Réplique réexécute des paquets de réplication publics et publie un rapport par paquet. Nous avons réexécuté le vôtre, « Oil Price Shocks, Sovereign Risk, and Bank Interest Rates Under Full Dollarization » (OIL_ECU_replication_package_v1.0.0.zip). Avant publication, nous vous communiquons les faits. Vous disposez de quatorze jours à compter de la date de cet envoi pour répondre ; votre réponse, si elle vient, sera jointe au rapport sans modification.

**Ce qui a été fait.** Pipeline complet `bash run_all.sh` avec `SKIP_DOWNLOAD=1`, dans un conteneur sans réseau (R 4.6.1, seasonal 1.11.0, x13binary 1.1.61.2, urca 1.3.4, strucchange 1.6.0, ggplot2 4.0.3 ; Python 3.14.8, pandas 2.3.3, numpy 2.4.6). La série VIX a été téléchargée à part (FRED, jusqu'au 22/09/2026) et renommée comme le fait `01_fetch_fred.py`. Exécution terminée avec le code 0 (`run_conteneur.log`, `etat_6.log`).

**Ce qui a été constaté.**
- Les 31 tables CSV de `output/tables/` ont chacune un homologue régénéré. Sur 104 628 cellules comparées (tolérance relative 10⁻⁶) : 47 958 égales au caractère près, 12 121 dans la tolérance, 44 549 hors tolérance. À 10⁻² : 6 381 hors tolérance ; à 10⁻¹ : 3 170 (`comparaison_tolerance.log`, `comparaison_tolerance_1e-2.log`, `comparaison_tolerance_1e-1.log`, commande `python3 -I compare_tolerance.py <tables du paquet> <tables régénérées> <tolérance>`).
- Concordent (aucune cellule hors 10⁻⁶) : `descriptives.csv`, `unit_roots.csv`, `kpss_breaks.csv`, `lag_selection_{deposit,lending}_rate.csv`, `lp_iv_firststage.csv`, `instrument_relevance.csv`, `x13_diagnostics.csv`.
- Divergent : les autres, par exemple `bvar_hyper_*.csv` (10 cellules sur 33 hors tolérance, écart relatif max 0,35 %), `irf_C0_*.csv` (740 et 741 cellules sur 4 152), `vix_freeze.csv` (120 sur 200, écart max 0,76 %), `lp_iv_irfs.csv` (4 sur 5 010, écart max 4,9×10⁻⁵).
- Une seconde exécution, même image, même fichier VIX, redonne exactement les mêmes 104 628 cellules (`repet_1e-6.log`).
- L'empreinte du fichier VIX téléchargé diffère de celle du millésime de l'article (`check_vix.log`) ; le nombre d'observations non manquantes est identique, 9 279 (`diag_vix.log`).

**Ce qui n'est pas établi.** La cause de l'écart. Millésime du VIX, versions logicielles, bibliothèques numériques de l'image, tirages aléatoires : aucune piste n'a été isolée. Le rapport ne compare pas les tables aux nombres de l'article (portée *paquet*) et ne se prononce pas sur ses conclusions.

Verdict proposé : **divergent**, portée **paquet**. Couverture : *régénération*.

Le rapport complet, avec toutes les commandes et tous les journaux, se trouve dans `rapports/zenodo-23585246/` du dépôt du projet. Si vous disposez d'éléments qui expliquent l'écart (graines, versions, millésime des données), nous les joindrons volontiers.

Cordialement,
Réplique
