/*
    FOR the NEO2.1 and 3.0 to work for companies, the bedrift and privat
    skillemappe have to be created in Fokus and registrered in SalesMaker.
    To update the quality of companies, we need a script that creates a
    skillemappe in Fokus and updating SalesMaker wit h the skillemappe
    BAN number.

    SQL to retrieve MANs that are missing a skillemappe:
*/
/*
SELECT a.ban, a.sm_key, a.sm_desc, a.enter_time, a.request_time,
       a.request_id, a.process_time, a.process_status, a.status_desc
  FROM ninjadata.salesmaker_ban_creator a
*/
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Underavtale:
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Underavtale: Bedrift
SELECT c.dummyban AS "MAN", c.internal_sm_key AS "SM_KEY", 
       'BEDRIFT_ABO_DUMMY' AS "SM_DESC", 'BEDRIFT' AS "ADDITIONAL_NAME",
       NULL AS "ENTER_TIME", NULL AS "REQUEST_TIME", 
       'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
       NULL AS "PROCESS_TIME", 'WAITING' AS "PROCESS_STATUS", NULL AS "STATUS_DESC" 
  FROM esm_orion_agreement_dummyban c
 WHERE c.product_key = 65
   AND c.value_key = 'RAMMEAVTALE'
   AND c.internal_sm_key NOT IN (SELECT er9_key
                                   FROM er9_multivalues
                                  WHERE er9_atribute = 'BEDRIFT_ABO_DUMMY')
   --AND c.dummyban = '100248509'
;

--== Underavtale: Privat
SELECT c.dummyban AS "MAN", c.internal_sm_key AS "SM_KEY",
       'PRIVAT_ABO_DUMMY' AS "SM_DESC", 'PRIVAT' AS "ADDITIONAL_NAME",
       NULL AS "ENTER_TIME", NULL AS "REQUEST_TIME",
       'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
       NULL AS "PROCESS_TIME", 'WAITING' AS "PROCESS_STATUS", NULL AS "STATUS_DESC"
--SELECT c.*
  FROM esm_orion_agreement_dummyban c
 WHERE c.product_key = 65
   AND c.value_key = 'RAMMEAVTALE'
   AND c.internal_sm_key NOT IN (SELECT er9_key
                                   FROM er9_multivalues
                                  WHERE er9_atribute = 'PRIVAT_ABO_DUMMY')
   --AND c.dummyban = '100248509'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Avtale:
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Avtale: Bedrift
SELECT c.man, c.internal_sm_key AS "SM_KEY", 'BEDRIFT_ABO_DUMMY' AS "SM_DESC", 
       'BEDRIFT' AS "ADDITIONAL_NAME", NULL AS "ENTER_TIME", NULL AS "REQUEST_TIME",
       'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
       NULL AS "PROCESS_TIME", 'WAITING' AS "PROCESS_STATUS", NULL AS "STATUS_DESC"
  FROM esm_orion_agreement c
 WHERE c.product_key = 65
   AND c.value_key = 'RAMMEAVTALE'
   AND c.internal_sm_key NOT IN (SELECT er9_key
                                   FROM er9_multivalues
                                  WHERE er9_atribute = 'BEDRIFT_ABO_DUMMY')
   --AND c.man = '100168400'
;

--== Underavtale: Privat
SELECT c.man, c.internal_sm_key AS "SM_KEY", 'PRIVAT_ABO_DUMMY' AS "SM_DESC",
       'PRIVAT' AS "ADDITIONAL_NAME", NULL AS "ENTER_TIME", NULL AS "REQUEST_TIME",
       'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID",
       NULL AS "PROCESS_TIME", 'WAITING' AS "PROCESS_STATUS", NULL AS "STATUS_DESC"
  FROM esm_orion_agreement c
 WHERE c.product_key = 65
   AND c.value_key = 'RAMMEAVTALE'
   AND c.internal_sm_key NOT IN (SELECT er9_key
                                   FROM er9_multivalues
                                  WHERE er9_atribute = 'PRIVAT_ABO_DUMMY')
   --AND c.man = '100168400'
;

