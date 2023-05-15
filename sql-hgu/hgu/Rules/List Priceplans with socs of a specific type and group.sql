--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==  
--== List a priceplan (with its' name) and all available socs (with their names)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   a.subscription_type_id, b.description AS "PP_DESCRIPTION", a.soc,
         d.description AS "SOC_DESCRIPTION", e.soc_type, e.soc_group,
         a.effective_date, a.expiration_date
    FROM subscription_types_socs a,
         subscription_type_desc b,
         socs_soc_descriptions c,
         soc_descriptions d,
         socs e
   WHERE A.SOC = E.SOC
     AND e.soc_type = 'VOICEMAIL'
     AND E.SOC_GROUP IN
                  ('VMS+')
     AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND a.subscription_type_id = b.subscription_type_id(+)
     AND b.language_code = 'NO'
     AND a.soc = c.soc(+)
     AND c.soc_name_id = d.soc_name_id(+)
     AND d.language_code = b.language_code
--ORDER BY a.subscription_type_id, a.soc, e.soc_type, e.soc_group;
ORDER BY e.soc_type, e.soc_group, a.soc, a.subscription_type_id;
/*         
         
   WHERE a.subscription_type_id IN ('PSTCREG1')
     AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND a.subscription_type_id = b.subscription_type_id(+)
     AND b.language_code = 'NO'
     AND a.soc = c.soc(+)
     AND c.soc_name_id = d.soc_name_id(+)
     AND d.language_code = b.language_code
ORDER BY a.subscription_type_id, a.soc
*/

