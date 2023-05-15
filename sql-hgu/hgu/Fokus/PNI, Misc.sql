SELECT a.*
  FROM pnp@prod a
 WHERE a.pni LIKE 'SIKA';

SELECT a.pni_type, COUNT(*) AS "COUNT"
  FROM pnp a
  WHERE a.pni_type IN ('V' , 'C')
  GROUP BY a.pni_type
  ORDER BY a.pni_type;

SELECT a.pni_type, a.max_members, COUNT(*) AS "COUNT"
  FROM pnp a
  WHERE a.pni_type IN ('V' , 'C')
  GROUP BY a.pni_type, a.max_members
  ORDER BY a.pni_type, a.max_members;

SELECT a.*
  FROM pnp a
  WHERE a.pni_type IN ('V')
    AND a.pni BETWEEN '29999' AND '99999'
  ORDER BY a.pni
;

SELECT SUBSTR(a.pni, 0, 1) || '0000-' || SUBSTR(a.pni, 0, 1) || '9999' AS "PNI", COUNT(*) AS "COUNT"
  FROM pnp a
  WHERE a.pni_type IN ('V')
  GROUP BY SUBSTR(a.pni, 0, 1) || '0000-' || SUBSTR(a.pni, 0, 1) || '9999'
  ORDER BY SUBSTR(a.pni, 0, 1) || '0000-' || SUBSTR(a.pni, 0, 1) || '9999';

SELECT a.*
  FROM pnp a
 WHERE a.pni like 'SK%'
   AND a.pni_type IN ('C');