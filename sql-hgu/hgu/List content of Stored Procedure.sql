--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the actual content of the stored procedure
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.text
  FROM all_source a
  WHERE a.name = 'XXCU_BOL_TCA'
ORDER BY a.line
;

SELECT a.owner, a.name, a.line, a.text
  FROM all_source a
 WHERE a.owner LIKE 'NINJA%'
--   AND UPPER(a.text) LIKE '%MONHTLY%'
   AND a.name LIKE '%NP%'
ORDER BY 1,2,3,4
;
