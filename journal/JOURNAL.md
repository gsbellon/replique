# Journal du projet Réplique

Entrées en ordre antichronologique : la plus récente en tête. Chaque session en ajoute une, même vide. Les tokens sont relevés par le lanceur dans USAGE.tsv.

---

## 2026-10-16 — session de reprise (interactive, claude.ai, modèle Fable 5.1)

**Fait.** Relecture de la transmission du 16/10 et du contrat v1. Évaluation du projet par rapport à la question initiale : pertinent, pour trois raisons tenues (valeur sans audience, condition de fin, profil pauvre en tokens et riche en calcul) ; constat que la part humaine a été presque totale en un mois et que l'expérience réelle commence avec le canal. Vérification de la documentation produit : mode non interactif `claude -p`, jeton d'abonnement, routines cloud sans SSH, tâches de bureau liées à l'application ouverte, exécution auto-hébergée réservée à Team/Enterprise, tarifs API. Contrat amendé en v2 et validé par le propriétaire. VM Debian 13 « replique-pilote » créée sur le poste fixe du propriétaire (VirtualBox, 2 cœurs, 4 Go, NAT, redirection 127.0.0.1:2222 → 22 pour la console du propriétaire). Utilisateur `replab` dans la VM, Claude Code 2.1.301 installé, clé SSH générée ; `replab` créé sur sd-92569 avec sudo journalisé, podman, politique de sortie (SMTP interdit, 200 Mbit/s, connexions sortantes journalisées). Première connexion `replab@pilote → sd-92569` réussie après vérification de l'empreinte de l'hôte.

**Bloqué.** Rien.

**Décisions du propriétaire consignées.** Abonnement Max comme mode d'authentification, repli API seulement sur demande d'Anthropic. Pilote sur le poste fixe plutôt que sur le laptop (le laptop est partagé avec un tiers). Tailscale conservé sur l'hôte, hors VM.

**Amendement proposé (à porter en v2.1 à la prochaine revue).** Article 4, hors projet : « ni redirection de port » devient « ni redirection de port vers l'extérieur ; une redirection liée à 127.0.0.1 est admise pour la console du propriétaire ». Accepté oralement par le propriétaire le 16/10.

**Prochaine action.** Dépôt poussé sur GitHub (témoin n° 1). Première session auteur lancée à la main par le propriétaire, pour mesurer : `bin/session.sh auteur`. Objet : tranche verticale sur sd-92569.
