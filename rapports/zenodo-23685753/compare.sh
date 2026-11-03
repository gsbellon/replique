#!/bin/sh
# Ligne d'appel (depuis le pilote, à la racine du dépôt), après la fin de run.log :
#   scp rapports/zenodo-23685753/compare.sh rapports/zenodo-23685753/compare_csv.py sd-92569:work/z23685753/
#   bin/capture.sh rapports/zenodo-23685753/compare.log 'cd ~/work/z23685753 && sh compare.sh'
# Compare les fichiers livrés (pkg/) et régénérés (run/) : CSV de results/ (cellule par cellule), figures (cmp), sommes sha256.
P=pkg/energy_nowcasting_replication
python3 -I compare_csv.py $P/results run/results
for f in $(ls $P/figures); do
  if cmp -s "$P/figures/$f" "run/figures/$f"; then echo "IDENTIQUE figures/$f"; else echo "DIFFERENT  figures/$f"; fi
done
ls run/figures | wc -l
ls $P/figures | wc -l
echo "--- txt de results/"
for f in reproduction_summary.txt environment_report.txt; do
  if cmp -s "$P/results/$f" "run/results/$f"; then echo "IDENTIQUE $f"; else echo "DIFFERENT  $f"; fi
done
diff $P/results/reproduction_summary.txt run/results/reproduction_summary.txt
