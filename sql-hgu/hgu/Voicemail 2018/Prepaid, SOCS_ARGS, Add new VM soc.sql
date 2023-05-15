/*
** Simpy list the VMS entries...
*/
SELECT a.*
  FROM ninjaconfig.socs_args a
 WHERE a.argument = 'VMS'
   AND TRUNC(SYSDATE) BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE)
ORDER BY 1,2,3,4
;


SELECT UNIQUE a.*, c.soc AS "NEW_VM_SOC"
  FROM ninjaconfig.socs_args a, socs b, subscription_types_socs c
 WHERE a.argument = 'VMS'
   AND TRUNC(SYSDATE) BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE)
   AND a.priceplan_code || 'REG1' = c.subscription_type_id
   AND TRUNC(SYSDATE) BETWEEN c.effective_date AND NVL(c.expiration_date, SYSDATE)
   AND c.soc                      = b.soc
   AND b.soc_type                 = 'VOICEMAIL2'
   AND b.soc_group                = 'VMS2'
 ORDER BY 1,2
;


/*
** Expire...
*/
UPDATE ninjaconfig.socs_args a
   SET a.expiration_date = (
SELECT c.expiration_date
  FROM subscription_types_socs c
 WHERE a.argument = 'VMS'
   AND TRUNC(SYSDATE) BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE)
   AND a.priceplan_code || 'REG1' = c.subscription_type_id
   AND a.soc                      = c.soc
   AND SYSDATE                    > c.expiration_date
   AND (a.priceplan_code || 'REG1', a.soc) NOT IN (
            SELECT b.subscription_type_id, b.soc
              FROM subscription_types_socs b
             WHERE TRUNC(SYSDATE) BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE)
   
 ))
;

SELECT a.*, c.expiration_date
  FROM ninjaconfig.socs_args a, subscription_types_socs c
 WHERE a.argument = 'VMS'
   AND TRUNC(SYSDATE) BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE)
   AND a.priceplan_code || 'REG1' = c.subscription_type_id
   AND a.soc                      = c.soc
   AND SYSDATE                    > c.expiration_date
   AND (a.priceplan_code || 'REG1', a.soc) NOT IN (
            SELECT b.subscription_type_id, b.soc
              FROM subscription_types_socs b
             WHERE TRUNC(SYSDATE) BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE)
 )
;

/*
** Expire all old rules...
*/
UPDATE ninjaconfig.socs_args a
   SET a.expiration_date = TRUNC(SYSDATE)
 WHERE a.argument        = 'VMS'
   AND TRUNC(SYSDATE) BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE)
;

/*
** Due to contraints, rename the old argument.
*/
UPDATE ninjaconfig.socs_args a
   SET a.argument = 'VMS_OLD'
 WHERE a.argument = 'VMS'
;

/*
** Add new rules...
*/
INSERT INTO ninjaconfig.socs_args
SELECT UNIQUE 'VMS' AS ARGUMENT
     , REPLACE(a.subscription_type_id, 'REG1', '') AS PRICEPLAN_CODE
     , a.soc AS SOC
     , 'ADD_SERVICE' AS ACTION
     , NULL AS SUCCESS_SMS_ID
     , NULL AS ERROR_SMS_ID
     , TRUNC(SYSDATE) AS EFFECTIVE_DATE
     , NULL AS EXPIRATION_DATE
     , NULL AS NEXT_ACTION
  FROM subscription_types_socs a, socs s
 WHERE a.soc                       = s.soc
   AND s.soc_type                  = 'VOICEMAIL2'
   AND s.soc_group                 = 'VMS2'
   AND SYSDATE               BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscription_type_id NOT IN ( 'PDEFREG1', 'NINJAMASTER1' )
 ORDER BY 1,2
;

