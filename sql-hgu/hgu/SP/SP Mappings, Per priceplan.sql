/*
** List the SP-codes and products available for a certain priceplan.
** NB! This does not check towards channel-access!
*/
SELECT sp.sp_service_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc, d.description AS "AKA", 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICEPLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM sp_services_mapping sp, subscription_types_socs sts, socs s, socs_descriptions d
 WHERE sts.subscription_type_id IN ('PVSA' || 'REG1', 'PVSB' || 'REG1')
   AND SYSDATE   BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc         = s.soc
   AND s.soc_type      = sp.soc_type
   AND s.soc_group     = sp.soc_group
   AND s.soc           = d.soc
   AND d.language_code = 'NO'
--   AND s.soc_type      = 'ODB'
ORDER BY 1
;

/*
** Lists all mappings for a certain SP (Channel)
*/
SELECT sp.sp_service_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc, d.description AS "AKA", 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICEPLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM sp_services_mapping sp, subscription_types_socs sts, socs s, socs_descriptions d
 WHERE sts.subscription_type_id IN (SELECT c.subscription_type_id
                                      FROM sub_typ_soc_channel c
                                     WHERE c.channel_code = 'Telio'
                                       AND SYSDATE BETWEEN c.effective_date AND NVL(c.expiration_date, SYSDATE + 1))
   AND SYSDATE   BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc         = s.soc
   AND s.soc_type      = sp.soc_type
   AND s.soc_group     = sp.soc_group
   AND s.soc           = d.soc
   AND d.language_code = 'NO'
--   AND s.soc_type      = 'ODB'
ORDER BY 1
;

/*
** Same as above, but filtered...
*/
SELECT sp.sp_service_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc, 'which is allowed on' AS "ALLOWED_ON", REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICEPLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM sp_services_mapping sp, subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id IN ('PVSA' || 'REG1', 'PVSB' || 'REG1')
   AND SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc       = s.soc
   AND s.soc_type    = sp.soc_type
   AND s.soc_group   = sp.soc_group
--   AND s.soc         = 'MPODV15'
   AND s.soc_type    = 'ODB'
--   AND sp.sp_service_code LIKE '%GPRS%'
ORDER BY 1
;


