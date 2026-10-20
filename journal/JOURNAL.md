# Journal du projet Réplique

Entrées en ordre antichronologique : la plus récente en tête. Chaque session en ajoute une, même vide. Les tokens sont relevés par le lanceur dans USAGE.tsv.

---

## 2026-10-20T10:10Z — session relecteur (Sonnet 5.5, non interactive)

**Relu.** Commits depuis ma relecture de 09:45Z (63a0d71..HEAD) : registre initialisé (388b3f7), rectification (776f619), journal. Aucun rapport à l'état `brouillon` : `zenodo-23439616` reste `publiable`, inchangé, aucun nombre touché. Rien exécuté.

**Verdict de relecture.** Rien à relire côté rapports. `registre/chaine.tsv` lu à la main : 5 entrées, chaînage prev/hash cohérent d'une ligne à l'autre, tête `9c7bd9cd…ff193a` identique à celle du journal. Les empreintes des fichiers n'ont PAS été recalculées : Bash refusé dans cette session, donc `bin/registre.sh verifie` non exécuté par le relecteur.

**Blocages.** Aucun BLOCAGE. Aucune action contraire à CLAUDE.md repérée ; la régularisation de c4b425b est consignée comme demandé. Le commit n'a pas pu être fait par cette session (Bash refusé) : le lanceur le clôturera.

**Prochaine action.** Relecteur avec Bash autorisé pour `bin/registre.sh verifie` ; auteur : test d'altération sur copie, témoin Drive, second paquet.

---

## 2026-10-20T09:50Z — session auteur (Sonnet 5.5, non interactive)

**Fait.** Registre initialisé : `registre/chaine.tsv`, 5 entrées de type `rapport` pour `zenodo-23439616` (RAPPORT.md, RELECTURE.md, comparaison.log, mesure_A.log, mesure_B.log), inscrites une à une. `bash bin/registre.sh verifie` → « OK: 5 entrées, tête 9c7bd9cdf95af56509547dacb82f5daf63205a95be6ef2b8d0c780d8a6ff193a ». Limites mises à jour dans `registre/LISEZMOI.md`.

**Constaté.** Défaut bénin de `registre.sh` à la première inscription (message « No such file » de la redirection de `wc -l`), entrée correcte. Une boucle `for` composée a été refusée par Bash ; refait en commandes simples, sans contournement.

**Non fait.** Témoignage de la tête : le dépôt est poussé par le lanceur (GitHub), mais je n'ai pas d'outil pour Google Drive ; la tête ci-dessus est la valeur à témoigner. Pas de test d'altération. Journal non inscrit dans la chaîne.

**Prochaine action.** Relecteur : exécuter `bash bin/registre.sh verifie` et comparer la tête. Auteur ensuite : test d'altération sur copie, témoin Drive (à régler avec le propriétaire), puis second paquet.

---

## 2026-10-20T10:00Z — rectification par le mainteneur (session interactive) et le propriétaire

**Sessions perdues.** Les sessions auteur du 2026-10-19T19:00Z, relecteur du 2026-10-20T05:00Z et auteur du 2026-10-20T09:11Z n'ont pas eu lieu : le test de réseau ajouté au lanceur le 2026-10-19 (commit c4b425b) déclarait le réseau absent alors qu'il répondait. Cause : `ssh -T git@github.com` sort en code 1 par conception, ce qui, sous `set -o pipefail`, faisait échouer le tube malgré le message attendu. Les deux premières ont de plus été perdues sans trace, le test sortant du lanceur avant le relevé et le commit. Corrigé en deux temps (trace garantie, puis test compatible `pipefail`), vérifié dans les conditions du lanceur. Leçon : toute modification du lanceur est testée avec `set -uo pipefail` avant d'être poussée. Le remède à une panne de réseau annuelle a coûté trois sessions ; c'est consigné parce que les échecs du projet se publient avec ses succès.

**Régularisation.** Le commit c4b425b a aussi modifié l'« Ordre des opérations » de CLAUDE.md (registre avant second paquet), sur proposition du mainteneur, par la main du propriétaire, sans entrée de journal. Le relecteur du 2026-10-20T09:45Z l'a relevé à juste titre. Le propriétaire confirme l'avoir appliqué lui-même ; la modification est portée à l'ordre du jour de la première revue hebdomadaire avec les deux amendements déjà proposés, et l'historique des amendements sera complété à cette occasion. Règle retenue : toute modification de CLAUDE.md, planning compris, passe par une entrée de journal le jour même.

**Lanceur.** Liste d'outils auteur élargie à `bin/` (scripts du projet, code de confiance) : l'auteur ne pouvait exécuter ni `capture.sh` hier ni `registre.sh` aujourd'hui.

**Prochaine action.** Auteur : initialiser le registre, y inscrire le premier rapport, témoigner la tête. Relecteur : vérifier la chaîne.

---

## 2026-10-20T09:45Z — session relecteur (Sonnet 5.5, non interactive)

**Relu.** Commits depuis la relecture du 2026-10-19 (b6b26f1..HEAD) : `bin/registre.sh`, `registre/LISEZMOI.md`, `bin/session.sh`, journal. Aucun rapport à l'état `brouillon` : `zenodo-23439616` est déjà `publiable`, inchangé depuis ma relecture (aucun nombre touché). Rien exécuté.

**Verdict de relecture.** Rien à relire côté rapports. `registre.sh` lu : logique cohérente avec l'article 7, mais non testé ni exécutable, registre non initialisé (déjà noté par l'auteur).

**Blocages.** Aucun BLOCAGE. Point à confirmer par le propriétaire : le commit c4b425b a modifié CLAUDE.md (Ordre des opérations, étape 4) sans entrée de journal ni accord consigné ; l'article 8 veut une revue et l'accord du propriétaire. Si le propriétaire l'a fait lui-même, rien à reprocher ; sinon, à régulariser par amendement.

**Prochaine action.** Autoriser `bin/registre.sh` dans la liste d'outils auteur, puis initialiser le registre.

---

## 2026-10-20T09:40Z — session auteur (Sonnet 5.5, non interactive)

**Fait.** Étape 4 de l'Ordre des opérations (registre à chaînage de hachage) : écrit `bin/registre.sh` (ajoute / verifie / tete) et `registre/LISEZMOI.md` (format, limites). La session auteur de 09:11Z s'était close en code 4 sans trace propre (traces `.json`/`.err` du 09:34Z non suivies, commitées ici).

**Bloqué.** Bash refuse tout appel à `registre.sh` (`chmod`, `bash bin/registre.sh`, et une commande composée) : le script n'est NI exécuté NI testé, `registre/chaine.tsv` n'existe pas, le premier rapport n'est PAS inscrit, `bin/registre.sh` n'est pas exécutable (`chmod` refusé). Aucun contournement tenté. Cause probable : liste d'outils du lanceur (`bin/session.sh`) sans ce script.

**Prochaine action.** Lanceur/propriétaire : autoriser `bin/registre.sh` dans la liste d'outils auteur (versionnée). Puis auteur : `bash bin/registre.sh verifie`, inscrire les fichiers de `rapports/zenodo-23439616/` (type `rapport`), témoigner la tête sur GitHub et Drive. Second paquet seulement ensuite.

---

## 2026-10-19T08:10Z — session relecteur (Sonnet 5.5, non interactive)

**Relu.** Rapport `zenodo-23439616` après le commit bdd1652 de l'auteur : `RAPPORT.md`, `RELECTURE.md`, `comparaison.log`, `mesure_A.sh/.log`, `mesure_B.sh/.log`. Bash refusé : lecture par outils de fichiers seulement, rien exécuté. La session relecteur de 05:00Z avait échoué (réseau coupé, code 1) ; rien n'avait été relu.

**Verdict de relecture.** `zenodo-23439616` passé de `brouillon` à `publiable` (verdict « reproduit ») : objections 6 à 10 levées, chaque nombre retrouvé dans un log capturé, aucun mot ni intention proscrits. Réserve non bloquante : MD5 Zenodo issue d'un `curl` non joint.

**Blocages.** Aucun. Le BLOCAGE du 2026-10-18 est levé. Aucune action contraire à CLAUDE.md repérée dans le journal ni les commits.

**Prochaine action.** Auteur : second paquet ; corriger le `timeout` qui ne tue pas le conteneur. Publication du premier rapport : à l'auteur/lanceur, selon la procédure en vigueur.

---

## 2026-10-18T19:00Z — session auteur (Sonnet 5.5, non interactive)

**Fait.** Objections 6 à 10 de RELECTURE.md traitées pour zenodo-23439616, toutes sorties produites par `bin/capture.sh` : `comparaison.log` regénéré (contenu identique à la transcription manuelle), `mesure_A.log` (A remesuré : 7,189 s ; digest, Python 3.12.15, figures, JSON triés), `mesure_B.log` (B remesuré sur copie neuve : 858 s, code 0, écart 0,0 partout). Scripts `mesure_A.sh`, `mesure_B.sh` versionnés avec lignes d'appel. Rapport corrigé : erratum, « moins de 10 minutes » était faux ; « 29 + 5 trajectoires » retiré faute de commande ; en-tête de `lance_comparaison.sh` harmonisé. Le rapport reste `brouillon`.

**Constaté.** Le sha256 de `results_cnsns_geometry.json` diffère entre fourni, run2 et run4 (trois valeurs) bien que tous les nombres soient identiques ; cause non établie (hypothèse : ordre d'écriture dépendant des processus).

**Bloqué.** Rien de bloquant. Une première commande composée mêlant `cat` local et `ssh` a été refusée ; refaite en commandes simples. Pas de contact extérieur.

**Prochaine action.** Relecteur : revérifier 6 à 10 (réponse dans RELECTURE.md) et passer à `publiable` ou bloquer. Auteur : second paquet ; corriger le `timeout` qui ne tue pas le conteneur (`--name` + `podman kill`, esquissé dans `mesure_B.sh`).

---

## 2026-10-18T05:00Z — session relecteur (Sonnet 5.5, non interactive)

**Relu.** Rapport `zenodo-23439616` (brouillon) après les commits de l'auteur 16f30a2 et 142dbd5 ; `compare.py`, `lance_comparaison.sh`, `comparaison.log`. Bash refusé dans cette session : lecture par outils de fichiers seulement, aucun test d'exécution.

**Verdict de relecture.** Rapport laissé en `brouillon`. Objections 1, 2, 4, 5 levées ; nouvelles objections 6 à 10 dans RELECTURE.md (log transcrit à la main présenté comme sortie complète ; commande incohérente ; durée 7,6 s sans sortie de `time` ; quelques nombres sans commande jointe).

**Blocages.** BLOCAGE : publication de zenodo-23439616, pour les raisons ci-dessus. Aucune action contraire à CLAUDE.md repérée.

**Prochaine action.** Auteur : relancer la comparaison avec redirection réelle, traiter 6 à 9.

---

## 2026-10-17T19:05Z — session auteur (Sonnet 5.5, non interactive)

**Fait.** Objections 1 à 5 de RELECTURE.md traitées pour zenodo-23439616. `compare.py` et `lance_comparaison.sh` versionnés dans le répertoire du rapport ; lancés sur sd-92569 (`ssh sd-92569 'cd ~/work/z23439616 && sh lance_comparaison.sh'`), sortie transcrite dans `comparaison.log`. Résultats : écart relatif max 0,0 sur 102 190 et 15 580 champs, en A et en B. **Correction** : `study` compte 105 champs numériques, pas 106 (erreur de la première version, corrigée dans le rapport). Sommes sha256 complètes et `md5sum pkg.zip` = MD5 annoncé par Zenodo (`f8868393…`). `run.log` et `run2.log` copiés dans le dépôt par `scp`. Durées A (7,6 s) et B (« < 10 min ») : sorties de `time` non conservées, le rapport le dit au lieu de les affirmer. Le rapport reste `brouillon`.

**Bloqué.** Deux commandes Bash composées (redirection `>` / `tee` / `&&` locaux) refusées par le mode d'autorisation ; refaites en commandes simples et outils d'écriture, sans contournement. `comparaison.log` a donc été écrit à la main depuis la sortie affichée, non redirigée : à vérifier par le relecteur en relançant la commande. Durée de B toujours inconnue.

**Prochaine action.** Relecteur : revérifier le rapport contre RELECTURE.md. Auteur : si rien ne bloque, choisir un second paquet et mesurer la durée avec `/usr/bin/time -v` consignée dans un fichier ; corriger le `timeout` qui ne tue pas le conteneur (`podman run --timeout` ou `--name` + `podman kill`).

---

## 2026-10-17T18:27Z — session relecteur (Sonnet 5.5, non interactive)

**Relu.** Dépôt depuis la relecture de 18:25Z : aucun nouveau commit de l'auteur, rapport `zenodo-23439616` et `bin/` inchangés (le script de comparaison reste absent).

**Verdict de relecture.** Rapport laissé en `brouillon` ; objections de RELECTURE.md inchangées et toujours ouvertes.

**Blocages.** Le blocage de publication de zenodo-23439616 demeure. Aucune action contraire à CLAUDE.md repérée.

**Prochaine action.** Auteur : lever les objections 1 à 4 de RELECTURE.md.

---

## 2026-10-17T18:25Z — session relecteur (Sonnet 5.5, non interactive)

**Relu.** Rapport `zenodo-23439616` (brouillon) ; journal et commits depuis 4289982 (sessions auteur 17:16Z à 17:39Z).

**Verdict de relecture.** Rapport laissé en `brouillon` : le script de comparaison qui produit les écarts (106 / 102 190 / 15 580 champs, écart 0,0) n'est ni cité ni versionné ; sommes sha256 abrégées sans commande ; journaux bruts hors dépôt. Objections détaillées dans `rapports/zenodo-23439616/RELECTURE.md`. Le verdict « reproduit » paraît plausible une fois ces points levés. Rien de modifié dans le rapport.

**Blocages.** BLOCAGE : publication de zenodo-23439616 bloquée pour les raisons ci-dessus. Aucune action contraire à CLAUDE.md repérée dans le journal ni les commits. Une commande Bash groupée de cette session a été refusée par le mode d'autorisation ; refaite avec les outils d'édition.

**Prochaine action.** Auteur : lever les objections 1 à 4 de RELECTURE.md.

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
