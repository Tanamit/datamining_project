\echo '--- 3. rows sharing (nameorig, step)'
WITH dup AS (
  SELECT nameorig, step FROM paysim_raw
  GROUP BY nameorig, step HAVING COUNT(*) > 1
)
SELECT p.* FROM paysim_raw p JOIN dup USING (nameorig, step)
ORDER BY p.nameorig, p.step
LIMIT 10;

\echo '--- 4. platform flag vs ground truth'
SELECT isflaggedfraud, isfraud, COUNT(*) AS n
FROM paysim_raw
GROUP BY 1, 2
ORDER BY 1, 2;

\echo '--- 5. destination account prefix and zero balances'
SELECT LEFT(namedest, 1) AS dest_prefix,
       COUNT(*) AS n,
       COUNT(*) FILTER (WHERE oldbalancedest = 0 AND newbalancedest = 0) AS both_zero,
       SUM(isfraud) AS fraud_n
FROM paysim_raw
GROUP BY 1
ORDER BY 1;

\echo '--- 6. origin balance consistency'
SELECT type, COUNT(*) AS n,
       COUNT(*) FILTER (
         WHERE ABS(oldbalanceorg
                   + CASE WHEN type = 'CASH_IN' THEN amount ELSE -amount END
                   - newbalanceorig) > 0.01
       ) AS orig_mismatch
FROM paysim_raw
GROUP BY type
ORDER BY type;
