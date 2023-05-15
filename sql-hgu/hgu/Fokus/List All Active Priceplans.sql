--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all priceplans that are allowed to exist, perhaps not for sale,
--== but still exist.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT RTRIM(a.soc) AS "SOC", RTRIM(a.soc_description) AS "SOC_DESCRIPTION",
       a.sale_eff_date, a.for_sale_ind
  FROM soc a
  WHERE a.soc_status   = 'A'
    AND a.service_type = 'P'
    AND NVL(a.expiration_date, TO_DATE('4700', 'YYYY')) > SYSDATE
    AND a.soc_description NOT LIKE 'IKKE I BRUK%'
  ORDER BY a.soc;

--== Display all columns...
SELECT a.*
  FROM soc a
  WHERE a.soc_status   = 'A'
    AND a.service_type = 'P'
    AND NVL(a.expiration_date, TO_DATE('4700', 'YYYY')) > SYSDATE
    AND a.soc_description NOT LIKE 'IKKE I BRUK%'
  ORDER BY a.soc;

