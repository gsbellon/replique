# Journal du projet Réplique

Entrées en ordre antichronologique : la plus récente en tête. Chaque session en ajoute une, même vide. Les tokens sont relevés par le lanceur dans USAGE.tsv.

---

## 2026-10-17T17:40Z — session auteur (Sonnet 5.5, non interactive)

**Fait.** Première tranche verticale complète. Paquets examinés sur Zenodo (via `curl` depuis sd-92569) : 18592832 (gretl, image absente), 21342547 (dump de 1 Go + PostgreSQL + heures de calcul), 20581409 (Stata, hors périmètre). Retenu : Zenodo 23439616 (Python/NumPy/Matplotlib, hors ligne, 345 ko). Dépendances installées depuis PyPI dans une étape réseau sans code du paquet, puis exécution sous `bin/sandbox-args.txt` : mode par défaut (7,6 s) et recalcul complet `--recompute` (< 10 min, 6 processus), tous deux code 0. Les 118 000 nombres des trois JSON fournis sont retrouvés avec un écart relatif de 0,0. Rapport `rapports/zenodo-23439616/RAPPORT.md` en `brouillon`, verdict proposé : reproduit.

**Bloqué.** Une commande groupée (mkdir + scp des journaux vers le dépôt) a été refusée par le mode d'autorisation ; pas de contournement. Les journaux bruts restent sur sd-92569 (`~/work/z23439616/run.log`, `run2.log`). La comparaison ne porte que sur les JSON du paquet, pas sur l'article (limites dans le rapport). Un `timeout 540` placé devant `podman run` n'a pas tué le conteneur (arrêt seulement du client) : le conteneur a fini seul ; à corriger avant d'exécuter un paquet moins sage. Pas de contact extérieur.

**Prochaine action.** Relecteur : vérifier le rapport et ses limites, passer à `publiable` ou bloquer. Auteur : copier les journaux bruts dans le dépôt (commandes simples), écrire un script `bin/` de la procédure (téléchargement, build des dépendances, exécution, comparaison), puis choisir un second paquet.

---

## 2026-10-17T17:36Z — session auteur (Sonnet 5.5, non interactive)

**Fait.** Vérifié sur sd-92569 en une seule connexion SSH (utilisateur `replab`, uid 1001, `sudo` pour tc) : `ssh sd-92569 'sudo tc qdisc show dev enp1s0f0'` → `tbf rate 200Mbit` en place ; 8 cœurs, 64 Go, 879 Go libres (`nproc`, `free -m`, `df -h /`). Image `docker.io/library/python:3.12-slim` tirée (`podman pull`). Bac à sable éprouvé : `podman run --rm --network none --cap-drop all --security-opt no-new-privileges --read-only python:3.12-slim ...` → capacités effectives `0000000000000000` (`/proc/self/status`), connexion vers 1.1.1.1 → `Network is unreachable`. L'uid 0 interne correspond à l'uid 1001 de l'hôte (podman sans root). Options consignées dans `bin/sandbox-args.txt`. `curl -sI https://zenodo.org/api/records/1` → HTTP 500 : le service répond, mais ce test ne prouve pas l'accès à un jeu de données. Non testé : montage en lecture seule d'un paquet.

**Bloqué.** Rien de technique. Aucun paquet tiers choisi ni exécuté. Une commande Bash groupée (écriture du journal par script) a été refusée par le mode d'autorisation de la session ; l'écriture a été refaite avec les outils d'édition, sans contournement.

**Prochaine action.** Choisir un petit paquet de réplication public (Zenodo/Dataverse, logiciel libre, quelques minutes de calcul), le télécharger dans un répertoire neuf sur l'exécuteur, exécuter sous `bin/sandbox-args.txt`, rédiger rapports/<id>/RAPPORT.md en `brouillon`.

---

## 2026-10-17T17:35Z — rectification par le propriétaire et le mainteneur (session interactive)

**Rectifie** l'entrée du 2026-10-17T17:16Z, point « aucune limite de débit sortant en place ». **Ce constat était faux.** Vérifié en `gilles` avec `sudo tc qdisc show` : `qdisc tbf 8001: dev enp1s0f0 root rate 200Mbit burst 8Mb lat 400ms` est en place depuis le 2026-10-16 19:20 CEST, posée par `replab-egress.service` (statut : exited, succès). La session auteur avait interrogé `tc` sans `sudo`, ce qui renvoie une liste vide pour un utilisateur ordinaire, et a conclu à une absence sans l'avoir établie. Le mainteneur en session interactive a répété l'erreur en reprenant ce constat sans le vérifier. Leçon portée au prompt auteur : un constat d'absence doit dire comment il a été établi et avec quels droits.

**Cause du « Connection refused »** : règle `ufw limit 22/tcp`, qui bloque une adresse après six connexions en trente secondes. Remplacée par le propriétaire par `ufw allow 22/tcp` (v4 et v6) ; l'authentification par clé seule et `MaxAuthTries 4` restent. Vérifié ensuite depuis le pilote : `ssh sd-92569 hostname` → `sd-92569`.

**Incident au passage** : pendant le remplacement, ufw a converti les règles existantes au lieu d'en ajouter, et les suppressions qui ont suivi ont laissé le port 22 sans aucune règle pendant environ une minute, la session ouverte du propriétaire survivant. Rétabli aussitôt. Consigné parce que les échecs du projet se publient au même endroit que ses succès.

**L'arrêt d'office de la session 17:16Z était correct** : machine au comportement inexpliqué, aucune modification faite. Première application réelle de l'article 3.

**Mesure** : première session complète, 99 s, 18 tours, 0,17 $ estimés, modèle Sonnet 5.5 (défaut de Claude Code sous abonnement).

**Prochaine action.** Tranche verticale sur sd-92569 : choix d'un paquet, image podman, exécution, rapport brouillon.

---

## 2026-10-17T17:16Z — session auteur (Sonnet 5.5, non interactive)

**Fait.** Diagnostic des deux sessions précédentes (17:10 et 17:15, code 1, sorties `.json` vides, `.err` vides, 1 tour, coût 0) : cause non établie depuis l'intérieur ; cette session-ci a tourné, donc la panne est intermittente ou corrigée. Vérification de l'exécuteur sd-92569 : connexion OK (utilisateur `replab`, uid 1001), podman 5.4.2 rootless, pilote overlay, aucune image. Politique de sortie examinée : port 25 interdit (règle ufw `tcp dport 25 drop`, 0 paquet) ; journalisation des nouvelles connexions de l'uid 1001 (table `inet replab`, limitée à 20/s) ; **aucune limite de débit sortant en place** (pas de `tc`, aucune règle nft de débit), alors que l'entrée du 16/10 la déclare à 200 Mbit/s. Écart à corriger : l'article 4 exige la limite avant la première exécution d'un paquet inconnu.

**Bloqué.** Après quelques connexions SSH rapprochées, sd-92569 a répondu « Connection refused » sur le port 22 (deux essais). Hypothèse la plus probable : la règle ufw `limit` sur le port 22 (visible dans le jeu de règles, 74 paquets déjà bloqués) a réagi à mes connexions successives ; non vérifiée. Faute de pouvoir l'exclure, arrêt d'office de l'article 3 (machine au comportement inexpliqué) : aucune autre commande tentée, aucune modification faite sur l'exécuteur.

**Aucune exécution de paquet** n'a eu lieu.

**Prochaine action.** (1) Le propriétaire ou la prochaine session vérifie que sd-92569 répond de nouveau (attendre quelques minutes ; consulter la console Scaleway si le refus persiste ; vérifier qu'aucune alerte d'abus n'est arrivée). (2) Puis, en une seule connexion SSH groupée, ajouter et persister une limite de débit sortant pour l'uid 1001 et confirmer la règle port 25. (3) Puis commencer la tranche verticale : choix d'un paquet, image podman, exécution. (4) Corriger le lanceur : le `.err` vide des sessions échouées ne dit rien ; faire écrire `claude --version` et le code de sortie dans le `.err`.

---

## 2026-10-16 — session de reprise (interactive, claude.ai, modèle Fable 5.1)

**Fait.** Relecture de la transmission du 16/10 et du contrat v1. Évaluation du projet par rapport à la question initiale : pertinent, pour trois raisons tenues (valeur sans audience, condition de fin, profil pauvre en tokens et riche en calcul) ; constat que la part humaine a été presque totale en un mois et que l'expérience réelle commence avec le canal. Vérification de la documentation produit : mode non interactif `claude -p`, jeton d'abonnement, routines cloud sans SSH, tâches de bureau liées à l'application ouverte, exécution auto-hébergée réservée à Team/Enterprise, tarifs API. Contrat amendé en v2 et validé par le propriétaire. VM Debian 13 « replique-pilote » créée sur le poste fixe du propriétaire (VirtualBox, 2 cœurs, 4 Go, NAT, redirection 127.0.0.1:2222 → 22 pour la console du propriétaire). Utilisateur `replab` dans la VM, Claude Code 2.1.301 installé, clé SSH générée ; `replab` créé sur sd-92569 avec sudo journalisé, podman, politique de sortie (SMTP interdit, 200 Mbit/s, connexions sortantes journalisées). Première connexion `replab@pilote → sd-92569` réussie après vérification de l'empreinte de l'hôte.

**Bloqué.** Rien.

**Décisions du propriétaire consignées.** Abonnement Max comme mode d'authentification, repli API seulement sur demande d'Anthropic. Pilote sur le poste fixe plutôt que sur le laptop (le laptop est partagé avec un tiers). Tailscale conservé sur l'hôte, hors VM.

**Amendement proposé (à porter en v2.1 à la prochaine revue).** Article 4, hors projet : « ni redirection de port » devient « ni redirection de port vers l'extérieur ; une redirection liée à 127.0.0.1 est admise pour la console du propriétaire ». Accepté oralement par le propriétaire le 16/10.

**Prochaine action.** Dépôt poussé sur GitHub (témoin n° 1). Première session auteur lancée à la main par le propriétaire, pour mesurer : `bin/session.sh auteur`. Objet : tranche verticale sur sd-92569.
