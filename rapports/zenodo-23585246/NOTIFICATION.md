To: non établie
Source: aucune adresse établie par commande ; grep d'adresses dans le paquet extrait (rapports/zenodo-23585246/adresse.log, code 1, aucune occurrence) ; la fiche Zenodo et le PDF de l'article n'ont pas été lus pour l'adresse
Subject: Re-execution of your replication package (Zenodo 23585246) - measured differences, 14 days before publication

Dear Author,

Réplique is a project that re-executes publicly archived replication packages and publishes one report per package. We re-executed yours, "Oil Price Shocks, Sovereign Risk, and Bank Interest Rates Under Full Dollarization" (OIL_ECU_replication_package_v1.0.0.zip, Zenodo record 23585246). Before publication we send you the facts. You have fourteen days from the date of this message to reply; your reply, if any, will be attached to the report without modification. The absence of a reply is not interpreted in any way: at the end of the period the report will be published as it stands, and a reply received afterwards can still be attached to it.

What was done. The full pipeline `bash run_all.sh` with `SKIP_DOWNLOAD=1`, in a container without network access (R 4.6.1, seasonal 1.11.0, x13binary 1.1.61.2, urca 1.3.4, strucchange 1.6.0, ggplot2 4.0.3; Python 3.14.8, pandas 2.3.3, numpy 2.4.6). The VIX series was downloaded separately (FRED, through 2026-09-22) and renamed as `01_fetch_fred.py` does. The run finished with exit code 0 (`run_conteneur.log`, `etat_6.log`).

What was measured.
- Each of the 31 CSV tables in `output/tables/` has a regenerated counterpart. Over 104,628 cells compared (relative tolerance 1e-6): 47,958 identical character for character, 12,121 within tolerance, 44,549 outside tolerance. At 1e-2: 6,381 outside tolerance; at 1e-1: 3,170 (`comparaison_tolerance.log`, `comparaison_tolerance_1e-2.log`, `comparaison_tolerance_1e-1.log`; command `python3 -I compare_tolerance.py <package tables> <regenerated tables> <tolerance>`).
- Agreeing (no cell outside 1e-6): `descriptives.csv`, `unit_roots.csv`, `kpss_breaks.csv`, `lag_selection_{deposit,lending}_rate.csv`, `lp_iv_firststage.csv`, `instrument_relevance.csv`, `x13_diagnostics.csv`.
- Differing: the other tables, for example `bvar_hyper_*.csv` (10 of 33 cells outside tolerance, maximum relative difference 0.35%), `irf_C0_*.csv` (740 and 741 of 4,152 cells), `vix_freeze.csv` (120 of 200, maximum 0.76%), `lp_iv_irfs.csv` (4 of 5,010, maximum 4.9e-5).
- A second run, same image, same VIX file, gives exactly the same 104,628 cells as the first (`repet_1e-6.log`).
- The checksum of the downloaded VIX file differs from the one recorded for the vintage used in the paper (`check_vix.log`); the number of non-missing observations is identical, 9,279 (`diag_vix.log`).

What is not established. The cause of the differences. The VIX vintage, software versions, numerical libraries in the image and random draws were all considered; no lead was isolated. The report does not compare the tables with the numbers in the article (scope: package) and takes no position on its conclusions.

Proposed verdict: divergent, scope: package. Coverage: regeneration.

The full report, with all commands and logs, is at https://github.com/gsbellon/replique/tree/main/rapports/zenodo-23585246. If you have information that explains the differences (seeds, versions, data vintage), we will gladly attach it.

Réplique — a replication lab for computational results
A project run by G. Bellon. Re-executions and reports are produced by an automated maintainer (Claude, by Anthropic) under a public charter: https://github.com/gsbellon/replique/blob/main/CLAUDE.md
contact@replique-lab.org · https://github.com/gsbellon/replique
