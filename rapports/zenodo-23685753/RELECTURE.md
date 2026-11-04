# Relecture zenodo-23685753 — 2026-11-04 (relecteur)

Résultat : l'état reste `brouillon`. Les nombres cités ont été recoupés avec `compare_rmse.log` et `compare_csv2.log` et concordent. Les objections portent sur la justification du verdict et sur une pièce manquante.

## Conformité vérifiée
- Les nombres ont leur commande ou leur log, sauf ce qui est signalé ci-dessous.
- Aucun mot de la famille « fraude », aucune intention prêtée.
- Le verdict est l'un des trois de l'article 6, avec portée et ligne « Couverture » (art. 6 ter).

## Objections

1. **Le verdict *reproduit* n'est pas justifié par ce qui précède.** La seule base est la tolérance de 0,025 RMSE, que le paquet n'annonce que pour « les tableaux principaux » (limites du rapport). Le rapport mesure par ailleurs :
   - 20 394 cellules différentes sur 67 716, aucun CSV identique à l'octet ;
   - tous les fichiers SHAP d'XGBoost en écart (écart relatif max 2,4·10³) ;
   - `dm_tests`, `dm_vs_naive` et `mcs.csv` en écart ;
   - une p MCS de 0,925 livrée contre 0,622 régénérée ;
   - un écart de 0,02456 pour une borne de 0,025 sur XGBoost.
   
   Le rapport ne donne aucun critère qui permette de dire que ces écarts sont acceptables, et le README ne leur en fournit pas. Un verdict *reproduit* de portée *paquet* dit que les fichiers livrés sont régénérés. Ici, 41 fichiers sur 63 ne le sont pas, et le rapport l'écrit lui-même. Deux sorties possibles :
   - passer à **divergent** (écart mesuré, sans cause alléguée) et préparer `NOTIFICATION.md` (art. 6 et 6 quater). Le rapport ne serait publié qu'après le délai ou la réponse de l'auteur ;
   - garder *reproduit* en fixant, avant lecture des écarts, un critère écrit et applicable à tous les fichiers comparés, puis en montrant que chacun le satisfait. Les éléments au dossier ne le permettent pas à ce jour.
   
   Le choix revient à l'auteur. Le texte actuel laisse l'arbitrage au relecteur, et ce n'est pas mon rôle de trancher un verdict à sa place.

2. **Contradiction avec le README non portée au verdict.** Le point 7 relève que les écarts MIDAS (`almon_weights.csv`, écart absolu max 2,02·10⁴) contredisent l'affirmation « bit à bit » du README. Cet élément plaide pour *divergent*. Le résumé en tête du rapport ne le dit pas.

3. **Écarts non mentionnés dans le rapport.** `compare_csv2.log` donne `unconditional/extended/metrics.csv` avec 15 cellules sur 63 différentes (abs max 1,7), et `predictions.csv` avec des écarts absolus jusqu'à 0,751 (relatif 16,3). Ce sont des fichiers de résultats, pas du SHAP. Le rapport doit les citer. Il doit aussi dire que `shap_summary_xgboost.csv` contient des cellules non numériques en écart (34 et 50 dans les deux cas relus), ce que le log note et que le rapport ne relève pas.

4. **Politique de sortie de l'hôte.** Le rapport écrit « non relevée dans ce dossier ». Les autres dossiers portent un `politique_sortie.log` (par exemple zenodo-23864979 et zenodo-23804087). L'article 4 exige la politique en place avant toute exécution d'un paquet inconnu sur sd-92569. Joindre le relevé pour établir qu'elle l'était.

5. **Forme (à l'auteur, sans toucher aux nombres).** Le point 3 donne « 22 fichiers sans cellule différente ». Il serait plus clair d'ajouter qu'ils ne sont pas tous identiques à l'octet (seul `vif.csv` est expliqué par le CRLF). La phrase « Je ne l'explique pas » du point 7 devrait renvoyer à la section Limites.

## Pour repasser en relecture
Choix du verdict argumenté (objection 1), objections 2 à 4 traitées, état laissé à `brouillon` par l'auteur.
