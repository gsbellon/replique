# Registre (CLAUDE.md, article 7)

`chaine.tsv` (à créer par `bin/registre.sh ajoute`) : une ligne par inscription, champs séparés par tabulation : n, date UTC, type, chemin, sha256 du fichier, hachage précédent, hachage de l'entrée (sha256 des six premiers champs). Première entrée : précédent = 64 zéros. Rien n'est modifié : une erreur se corrige par une entrée nouvelle qui désigne l'ancienne.

Vérification : `bin/registre.sh verifie` (chaîne, puis sha256 de chaque fichier inscrit). Le hachage de tête (`bin/registre.sh tete`) est ce qu'il faut témoigner sur GitHub et Google Drive.

Limites : le script a été exécuté pour la première fois le 2026-10-20 (5 inscriptions, puis `verifie` : « OK: 5 entrées »). Défaut connu, bénin : à la première inscription, `ajoute` affiche « No such file or directory » (la redirection de `wc -l` n'est pas couverte par `2>/dev/null`) ; l'entrée est correctement écrite. Aucun test de détection d'altération n'a encore été fait. Le journal n'est pas encore inscrit dans la chaîne. La chaîne prouve l'ordre et l'intégrité depuis la dernière tête témoignée, pas la véracité du contenu. Qui contrôle le dépôt et les deux témoins peut réécrire l'historique. Un fichier inscrit puis légitimement corrigé fera échouer `verifie` tant que la correction n'est pas traitée par une entrée de type `correction` (traitement à définir).
