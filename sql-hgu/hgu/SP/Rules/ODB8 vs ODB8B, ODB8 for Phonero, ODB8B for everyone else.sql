/*
SELECT a.*
  FROM subscription_types_socs a
 WHERE a.soc = 'ODB8'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
;

SELECT a.*
  FROM subscription_types_socs a
 WHERE a.soc = 'ODB8B'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscription_type_id IN ('NINJAMASTER1', 'PDEFREG1', 'PW10REG1')
;
*/
/*
** Start
*/

UPDATE subscription_types_socs a
   SET a.expiration_date = TRUNC(SYSDATE)
 WHERE a.soc = 'ODB8'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscription_type_id NOT IN ('NINJAMASTER1', 'PDEFREG1', 'PW10REG1')
;

UPDATE subscription_types_socs a
   SET a.expiration_date = TRUNC(SYSDATE)
 WHERE a.soc = 'ODB8B'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscription_type_id IN ('PW10REG1')
;


SELECT a.*
  FROM subscription_types_socs a
 WHERE a.soc IN (  'ODB8', 'ODB8B' )
--   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscription_type_id IN ('NINJAMASTER1', 'PDEFREG1', 'PW10REG1')
ORDER BY 2,1
;

UPDATE sub_typ_soc_channel a
   SET a.expiration_date = TRUNC(SYSDATE)
 WHERE a.soc = 'ODB8'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscription_type_id NOT IN ('NINJAMASTER1', 'PDEFREG1', 'PW10REG1')
;

UPDATE sub_typ_soc_channel a
   SET a.expiration_date = TRUNC(SYSDATE)
 WHERE a.soc = 'ODB8B'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscription_type_id IN ('PW10REG1')
;

SELECT a.*
  FROM sub_typ_soc_channel a
 WHERE a.soc IN (  'ODB8', 'ODB8B' )
--   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscription_type_id IN ('NINJAMASTER1', 'PDEFREG1', 'PW10REG1')
ORDER BY 2,1
;

INSERT INTO spm_service_mapping 
VALUES('BAR_DATA_ALL','ODB','ODB8B',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00', 'YYYY-MM-DD HH24:MI'),NULL)
;

SELECT a.*
  FROM spm_service_mapping a
 WHERE sp_code = 'BAR_DATA_ALL'
ORDER BY 1,2,3
;

