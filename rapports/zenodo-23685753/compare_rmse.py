"""Écart de RMSE par modèle entre metrics_all.csv livré et régénéré. Ne lit que du texte ; n'exécute rien du paquet.
Ligne d'appel (sur sd-92569, depuis ~/work/z23685753) :
  python3 -I compare_rmse.py pkg/energy_nowcasting_replication/results/evaluation/metrics_all.csv run/results/evaluation/metrics_all.csv
Pour chaque (design, échantillon, modèle) : RMSE livré, RMSE régénéré, écart absolu. Puis, par modèle, l'écart max
et le nombre de lignes dépassant 0,025 (borne annoncée par le README du paquet pour XGBoost)."""
import csv, sys

BORNE = 0.025


def lit(chemin):
    with open(chemin, encoding="utf-8-sig", newline="") as f:
        return {(r["design"], r["sample"], r["model"]): float(r["rmse"]) for r in csv.DictReader(f)}


a, b = lit(sys.argv[1]), lit(sys.argv[2])
print("lignes livrées :", len(a), "| régénérées :", len(b), "| clés communes :", len(set(a) & set(b)))
par_modele = {}
for k in sorted(set(a) & set(b)):
    d = abs(a[k] - b[k])
    print("%-14s %-9s %-15s livré %.4f régénéré %.4f écart %.4g" % (k + (a[k], b[k], d)))
    par_modele.setdefault(k[2], []).append(d)
print("--- par modèle")
for m in sorted(par_modele):
    ds = par_modele[m]
    print("%-15s écart max %.4g | lignes > %.3f : %d sur %d" % (m, max(ds), BORNE, sum(x > BORNE for x in ds), len(ds)))
