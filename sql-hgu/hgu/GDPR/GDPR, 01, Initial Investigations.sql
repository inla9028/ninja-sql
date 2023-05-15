/*
** Identify all columns with a phone number, they might be of interest for GDPR
*/
SELECT a.*
  FROM all_tables a
 WHERE a.owner = 'NINJADATA'
ORDER BY 1,2
;

SELECT a.column_name, COUNT(1) AS "COUNT"
  FROM all_tab_cols a
 WHERE a.owner       = 'NINJADATA'
GROUP BY a.column_name
ORDER BY 1
;

SELECT a.*
  FROM all_tab_cols a
 WHERE a.owner       = 'NINJADATA'
   -- The white-list...
   AND a.column_name IN (
         -- Subscription centric
         'CTN', 'MSISDN', 'SUBSCRIBER_NO', 'SUBSCRIBER_NR',
         -- BAN centric
         'BAN', 'BAN_FROM', 'BAN_TO', 'CUSTOMER_ID', 'NEW_BAN', 'TARGET_BAN',
         -- SIM centric
         'SIM', 'SIM_CARD', 'SIM_NO', 'SIM_NUMBER',
         -- Hmmmm....
         'MAN', 'MAN_BAN'
     )
   -- The black-list(s)
   AND a.table_name NOT LIKE 'BRAWE%'
   AND a.table_name NOT LIKE 'TMP%'
   AND a.table_name NOT IN (
        'BATCH_CREDIT_CHECK',
        'BATCH_SP_MOVEMENTS',
        'BCK_SERVICE_TRANSACTIONS',
        'GSM_BESTILLING', 'GSM_BESTILLING_TEST', 'GSM_BESTILLING_TEST_ARCHIVE', -- Test environment data in production.
        'MASTER_MOVER',
        'MASTER_SP_PP_TRANS',
        'MW_TMP_CTNS',
        'MWE_FIX_CANCELLED_KONTANT',
        'XX_ONE_OFF_SP_VMFAX_REPLACE'
   )
--   AND a.object_type LIKE 'C%'
ORDER BY 1,2,3
;


