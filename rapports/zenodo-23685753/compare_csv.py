"""Compare les CSV livrés (pkg/.../results) et régénérés (run/results), cellule par cellule. Ne lit que du texte ; n'exécute rien du paquet.
Ligne d'appel (sur sd-92569, depuis ~/work/z23685753) :
  python3 -I compare_csv.py pkg/energy_nowcasting_replication/results run/results
Pour chaque CSV livré : identique à l'octet, ou nombre de cellules différentes, écart absolu max, écart relatif max,
cellules non numériques différentes. Puis un total. Fichiers présents d'un seul côté listés."""
import csv, os, sys

livre, regen = sys.argv[1], sys.argv[2]


def nombre(s):
    try:
        return float(s)
    except ValueError:
        return None


noms_l = sorted(f for f in os.listdir(livre) if f.endswith(".csv"))
noms_r = sorted(f for f in os.listdir(regen) if f.endswith(".csv"))
print("CSV livrés :", len(noms_l), "| régénérés :", len(noms_r))
print("seulement livrés :", sorted(set(noms_l) - set(noms_r)))
print("seulement régénérés :", sorted(set(noms_r) - set(noms_l)))
ident = 0
tot_cell = tot_diff = 0
gamax = grmax = 0.0
for f in noms_l:
    if f not in noms_r:
        continue
    bl = open(os.path.join(livre, f), "rb").read()
    br = open(os.path.join(regen, f), "rb").read()
    if bl == br:
        ident += 1
        print("IDENTIQUE", f)
        continue
    rl = list(csv.reader(open(os.path.join(livre, f), encoding="utf-8", newline="")))
    rr = list(csv.reader(open(os.path.join(regen, f), encoding="utf-8", newline="")))
    if len(rl) != len(rr) or any(len(a) != len(b) for a, b in zip(rl, rr)):
        print("FORME DIFFERENTE", f, len(rl), len(rr))
        continue
    n = nd = nn = 0
    amax = rmax = 0.0
    for a, b in zip(rl, rr):
        for u, v in zip(a, b):
            n += 1
            if u == v:
                continue
            nd += 1
            x, y = nombre(u), nombre(v)
            if x is None or y is None:
                nn += 1
                continue
            d = abs(x - y)
            amax = max(amax, d)
            if x != 0:
                rmax = max(rmax, d / abs(x))
    tot_cell += n
    tot_diff += nd
    gamax = max(gamax, amax)
    grmax = max(grmax, rmax)
    print("DIFFERENT %s : %d/%d cellules, non numériques %d, abs max %.3g, rel max %.3g" % (f, nd, n, nn, amax, rmax))
print("TOTAL identiques à l'octet :", ident, "| différents (comparés) cellules :", tot_diff, "sur", tot_cell,
      "| abs max %.3g | rel max %.3g" % (gamax, grmax))
