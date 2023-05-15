--==
--== Display all dealer groups, and the number of dealers associated with them.
--==
SELECT g.dealer_group, g.description, COUNT(*) AS "NR_OF_DEALERS"
  FROM dealer_groups g, dealers d
 WHERE g.dealer_group = d.dealer_group(+)
GROUP BY g.dealer_group, g.description
ORDER BY g.dealer_group, g.description
;


--==
--== Display a set of dealers and their groups.
--==
SELECT d.dealer_code, g.dealer_group, g.description
  FROM dealers d, dealer_groups g
 WHERE 1 = 1
--   AND d.dealer_code LIKE '1000%'
   AND g.dealer_group = d.dealer_group(+)
ORDER BY d.dealer_code, g.dealer_group, g.description
;
