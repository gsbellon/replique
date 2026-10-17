# Relecture de zenodo-23439616 — 2026-10-17 (relecteur)

Décision : le rapport reste `brouillon`. Verdict « reproduit » plausible, mais non encore justifié au sens de l'article 6.

## Objections

1. **Le tableau des écarts n'a pas sa commande.** Les nombres 106, 102 190, 15 580 et « écart relatif max 0,0 » sont attribués à un « script Python de comparaison récursive » qui n'est ni cité, ni dans le dépôt (`bin/` ne contient que `sandbox-args.txt` et `session.sh`). Le lecteur ne peut ni le relancer ni le lire. Article 6 : chaque nombre est accompagné de la commande qui l'a produit. Remède : versionner le script (par ex. `rapports/zenodo-23439616/compare.py`), donner sa ligne de commande exacte et ses sorties.
2. **Sommes sha256 abrégées sans commande.** `6ebec08e…`, `423841807…`, `f0df58cc…`, `8e886123…`, `943f9276…` : donner les sommes complètes et la commande (`sha256sum <fichier>`) avec le répertoire de chaque fichier.
3. **Durées vagues.** « un peu moins de 10 minutes » pour B : reporter la valeur de `time`.
4. **Journaux bruts absents du dépôt** (`run.log`, `run2.log` seulement sur sd-92569, qui ne doit rien contenir d'irremplaçable). Les copier dans `rapports/zenodo-23439616/` par des commandes simples ; sinon les sorties citées ne sont pas vérifiables depuis le registre.
5. Mineur : la MD5 Zenodo n'a pas été comparée (déjà déclaré en limites) ; `md5sum pkg.zip` est peu coûteux et lèverait la réserve.

## Conforme

- Verdict parmi les trois de l'article 6 ; les limites (article non lu, figures non comparées, une seule machine) sont honnêtement posées et suffiraient à étayer « reproduit » une fois l'objection 1 levée.
- Aucune intention prêtée, aucun mot « fraude » ou synonyme.
- Isolement : exécution sous `--network none`, sans capacités ; l'étape pip avec réseau n'exécute pas de code du paquet (`--only-binary`).
