SELECT a.*
  FROM socs_args a
 WHERE a.argument = 'VMS'
   AND TRUNC(SYSDATE) BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE)
ORDER BY 1,2,3,4
;

/*
** List entries whom are still valid.
*/
SELECT a.*
  FROM socs_args a
 WHERE a.argument = 'VMS'
   AND TRUNC(SYSDATE) BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE)
   AND (a.priceplan_code || 'REG1', a.soc) IN (
            SELECT b.subscription_type_id, b.soc
              FROM subscription_types_socs b
             WHERE TRUNC(SYSDATE) BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE)
 )
ORDER BY 1,2,3,4
;

/*
** List entries whom are invalid.
*/
SELECT a.*
  FROM socs_args a
 WHERE a.argument = 'VMS'
   AND TRUNC(SYSDATE) BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE)
   AND (a.priceplan_code || 'REG1', a.soc) NOT IN (
            SELECT b.subscription_type_id, b.soc
              FROM subscription_types_socs b
             WHERE TRUNC(SYSDATE) BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE)
 )
ORDER BY 1,2,3,4
;

/*
** List entries whom are invalid, and the expiration date.
*/
SELECT a.*, c.expiration_date AS "EXP_DATE"
  FROM socs_args a, subscription_types_socs c
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
ORDER BY 1,2,3,4
;

/*
** Verify ...
*/
SELECT b.*
  FROM subscription_types_socs b
 WHERE b.subscription_type_id IN ( 'PKOC'||'REG1', 'PKOF'||'REG1', 'PKOG'||'REG1', 'PKOM'||'REG1', 'PKON'||'REG1', 'PKOP'||'REG1' )
   AND b.soc                  = 'VMKON'
--   AND TRUNC(SYSDATE) BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE)
ORDER BY 1,2
;

SELECT a.*
  FROM socs_args a
 WHERE a.argument = 'VMS'
   AND a.priceplan_code IN ( 'PKOC', 'PKOF', 'PKOG', 'PKOM', 'PKON', 'PKOP' )
   AND a.soc                  = 'VMKON'
ORDER BY 1,2
;

/*
** Expire...
*/
UPDATE socs_args a
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




