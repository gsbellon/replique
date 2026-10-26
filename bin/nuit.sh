#!/bin/bash
# Nuit de Réplique (article 5) : deux cycles auteur–relecteur enchaînés, lancés par cron à 21 h.
# Aucune session ne commence après 8 h 30 : la fenêtre se ferme à 9 h.
cd "$HOME/replique" || exit 2
for role in auteur relecteur auteur relecteur; do
  h=$((10#$(date +%H%M)))
  if [ "$h" -ge 830 ] && [ "$h" -lt 2100 ]; then
    echo "$(date -u +%FT%TZ) nuit : fenêtre fermée, $role non lancé"; break
  fi
  bin/session.sh "$role"
done
echo "$(date -u +%FT%TZ) nuit : terminée"
