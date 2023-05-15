--== Display co-existing socs, based on soc-type & group.
SELECT a.soc, a.coexisting_soc, a.coexisting_mode
  FROM ninjarules.coexisting_socs a, socs b
  WHERE b.soc_type      = 'NORDEN'
    AND b.soc_group     = 'NORD'
    AND b.soc          IN (a.soc, a.coexisting_soc)
  ORDER BY a.soc, a.coexisting_soc;

--== Display co-existing socs, based on soc.
SELECT a.soc, a.coexisting_soc, a.coexisting_mode
  FROM ninjarules.coexisting_socs a
  WHERE 'CONBC10' IN (a.soc, a.coexisting_soc)
  ORDER BY a.soc, a.coexisting_soc;

--== Display co-existing socs, based on soc.
SELECT a.soc, a.coexisting_soc, a.coexisting_mode
  FROM ninjarules.coexisting_socs a
  WHERE 'STOPINSUR' IN (a.soc, a.coexisting_soc)
    /*AND (
         a.soc LIKE 'ODB%'
      OR a.coexisting_soc LIKE 'ODB%'
    )*/
  ORDER BY a.soc, a.coexisting_soc;

--== Display co-existing socs, where the soc-name starts with...
SELECT a.soc, a.coexisting_soc, a.coexisting_mode
  FROM ninjarules.coexisting_socs a
 WHERE a.soc LIKE 'CONC%'
    OR a.coexisting_soc LIKE 'CONC%'
ORDER BY a.soc, a.coexisting_soc;


