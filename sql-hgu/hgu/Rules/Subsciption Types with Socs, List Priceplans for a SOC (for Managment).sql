--==
--== Display the price plans on which the soc (of type) is allowed.
--==
SELECT REPLACE(a.subscription_type_id, 'REG1', '') AS "PRICE_PLAN"
     , b.description AS "PP_DESC"
     , a.soc
     , c.description AS "SOC_DESC"
  FROM subscription_types_socs a, socs_descriptions b, socs_descriptions c, socs d
 WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
     AND a.soc = d.soc
--     AND d.soc_type = 'SPOTIFY'
--     AND d.soc_group = 'ORDER'
     AND d.soc IN ( 'IMS01', 'IMS02' )
     AND REPLACE(a.subscription_type_id, 'REG1', '') = b.soc
     AND b.language_code = 'NO'
     AND a.soc           = c.soc
     AND c.language_code = 'NO'
     AND a.subscription_type_id NOT IN ('NINJAMASTER1', 'PDEFREG1')
ORDER BY 1, 2, 3
;

SELECT REPLACE(a.subscription_type_id, 'REG1', '') AS "PRICE_PLAN"
     , b.description AS "PP_DESC"
     , a.soc
     , c.description AS "SOC_DESC"
  FROM subscription_types_socs a, socs_descriptions b, socs_descriptions c, socs d
 WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
     AND a.soc = d.soc
     --== List the socs you want...
     AND d.soc IN (
         'IMS01', 'IMS02'
     )
     AND REPLACE(a.subscription_type_id, 'REG1', '') = b.soc
     AND b.language_code = 'NO' -- We have language 'NO' and 'EN' for descriptions..
     AND a.soc           = c.soc
     AND c.language_code = 'NO' -- We have language 'NO' and 'EN' for descriptions..
     --== Avoid the two subscription types used internally by Ninja as a base...
     AND a.subscription_type_id NOT IN ('NINJAMASTER1', 'PDEFREG1')
ORDER BY 1, 2, 3
;

