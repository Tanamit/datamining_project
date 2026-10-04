\echo '--- 1. size and keys'
SELECT COUNT(*) AS rows_total,
       COUNT(DISTINCT nameorig) AS distinct_orig,
       COUNT(DISTINCT namedest) AS distinct_dest,
       COUNT(DISTINCT (nameorig, step)) AS distinct_orig_step,
       MIN(step) AS min_step, MAX(step) AS max_step
FROM paysim_raw;

\echo '--- 2. fraud rate by type'
SELECT type, COUNT(*) AS n, SUM(isfraud) AS fraud_n,
       ROUND(100.0 * SUM(isfraud) / COUNT(*), 4) AS fraud_pct
FROM paysim_raw
GROUP BY type
ORDER BY fraud_pct DESC;
