# Journal du projet Réplique

Entrées en ordre antichronologique : la plus récente en tête. Chaque session en ajoute une, même vide. Les tokens sont relevés par le lanceur dans USAGE.tsv.

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
