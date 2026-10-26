## Proposé le 2026-10-17 par le mainteneur (session interactive), pour la revue hebdomadaire

**Article 6, portée du verdict.** Le premier rapport (zenodo-23439616) établit que le paquet régénère ses propres fichiers de résultats, sans que l'article ait été lu. « Reproduit » est juste pour le paquet, mais le lecteur entendra « l'article est reproduit ». Proposition : chaque verdict porte une portée explicite parmi deux — *paquet* (les sorties fournies dans le dépôt de réplication sont régénérées) ou *article* (les nombres cités dans la publication sont retrouvés) — et un rapport de portée *paquet* ne prétend pas à la seconde. Les trois verdicts restent les seuls ; la portée les qualifie, elle ne les multiplie pas. Raison : la vérité du registre dépend de ce que le lecteur comprend, pas seulement de ce que le texte dit.

## Pour la première revue hebdomadaire (ajouté le 2026-10-20)

**Régularisation de c4b425b.** « Ordre des opérations », étape 4 : « Registre à chaînage de hachage (article 7) dans le dépôt, avec script de vérification ; premier rapport inscrit. Ensuite seulement : second paquet, VM sur les stations, relecteur déplacé, site public. » Appliqué le 2026-10-19 par le propriétaire sur proposition du mainteneur, avant revue. À confirmer et à inscrire à l'historique des amendements (v2.1).

**Amendement 127.0.0.1** (proposé le 2026-10-16) et **portée du verdict** (proposé le 2026-10-17) : déjà au dossier, ci-dessus.

## Proposé le 2026-10-23 par le propriétaire et le mainteneur, pour la revue n° 2

**Article 1, périmètre.** Ajouter aux exclusions « pour l'instant » : les paquets dont les données ne sont ni incluses ni en accès public direct (inscription, formulaire, accord de licence à signer). Le projet ne remplit aucun formulaire et n'ouvre aucun compte chez un tiers. Raison : l'article 6 réserve au propriétaire tout contact avec un tiers ; une réplication dont les données exigent une inscription n'est pas vérifiable par un lecteur qui ne l'a pas ; certains jeux (échantillons malveillants) sont incompatibles avec l'hébergement de l'exécuteur.

## Revue n° 2 (2026-10-26) : article 1 et article 5 acceptés, v2.2.

## Pour la revue n° 3 — convention « hors paquet »
Quand la commande documentée échoue mais qu'une correction minimale et nommée (un chemin, une version) suffit à retrouver les résultats, le verdict reste *inexécutable* (il porte sur le paquet tel que livré) et le rapport peut comporter une section « mesure hors paquet », clairement marquée, donnant la correction exacte et le résultat obtenu. Raison : c'est le cas le plus fréquent ; le lecteur et l'auteur du paquet ont besoin des deux informations, et le verdict ne doit pas récompenser une réparation que le paquet n'a pas faite.
