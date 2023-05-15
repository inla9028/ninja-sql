SELECT REPLACE(a.subscription_type_id, 'REG1', '') AS "PP"
     , d1.description AS "PP_DESC"
     , a.soc
     , d2.description AS "SOC_DESC"
     , a.add_mode, a.delete_mode, a.modify_mode
  FROM subscription_types_socs a, socs_descriptions d1, socs_descriptions d2
 WHERE SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
  AND REPLACE(a.subscription_type_id, 'REG1', '') = d1.soc
  AND d1.language_code                            = 'NO'
  AND a.soc                                       = d2.soc
  AND d2.language_code                            = 'NO'
--  AND a.subscription_type_id                   LIKE 'PSCS%'
  AND a.soc                                       = 'MBNPNI01'
ORDER BY 1,3
;
