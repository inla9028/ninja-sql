/*
** Inserts for a new SP + Dealer which may not access any others subscriptions.
*/

/*INSERT INTO dealers
SELECT 'NWCO' AS "DEALER_CODE", 'REGULAR' AS "DEALER_GROUP"
  FROM dual 
 WHERE 1 = 1
;*/

SELECT a.*
  FROM dealers a
 WHERE a.dealer_code IN ('NWCO')
ORDER BY 1
;


INSERT INTO channels
SELECT 'NewCo'            AS "CHANNEL_CODE"
     , 'NewCo SP Channel' AS "CHANNEL_DESC"
     , 'Y'                AS "DEFAULT_MAN_IND"
     , 'NWCO'             AS "DEFAULT_DEALER_CODE"
  FROM dual
 WHERE 1 = 1
;

SELECT a.*
  FROM channels a
 WHERE a.channel_code IN ('NewCo')
ORDER BY 1
;


INSERT INTO ninja_user
SELECT 'NewCo'     AS "USERNAME"
     , 'NewCo'     AS "DEFAULT_CHANNEL_CODE"
     , 'NINJA_SP' AS "CONTACT_ID"
  FROM dual
 WHERE  1 = 1
;

SELECT a.*
  FROM ninja_user a
 WHERE a.username IN ('NewCo')
ORDER BY 1
;


INSERT INTO service_providers
SELECT 'NewCo'                    AS "SERVICE_PROVIDER_CODE"
     , 293938312                  AS "ROOT_BAN"
     , 393938311                  AS "CURRENT_ACTIVE_BAN"
     , 250                        AS "MAX_SUBSCRIPTIONS"
     , 'NWCO'                     AS "DEALER_CODE"
     , 'S'                        AS "SHORT_NAME"
     , 'NO'                       AS "LANGUAGE_CODE"
     , 'TC'                       AS "BAN_SUB_TYPE"
     , '817'                      AS "OPERATOR_CODE"
     , 'NEWCO'                    AS "LAST_BUSINESS_NAME"
     , 'Subscriber'               AS "FIRST_NAME"
     , 'NOR'                      AS "ADR_COUNTRY"
     , '0403'                     AS "ADR_ZIP"
     , 'Sandakerveien 140'        AS "ADR_STREET_NAME"
     , 'Oslo'                     AS "ADR_CITY"
     , NULL                       AS "ADR_HOUSE_LETTER"
     , NULL                       AS "ADR_HOUSE_NO"
     , NULL                       AS "ADR_DOOR_NO"
     , NULL                       AS "ADR_STORY"
     , NULL                       AS "ADR_EMAIL"
     , '90'                       AS "PHYSICAL_HLR_CD"
     , 200                        AS "MIN_NO_OF_ACTIVATION_BANS"
     , 'M'                        AS "BAN_STRUCTURE_IND"
     , 10000                      AS "MAX_SUBS_PER_TREE"
     , NULL                       AS "EXPIRATION_DATE"
     , '5'                        AS "BILL_CYCLE"
  FROM dual a
 WHERE 1 = 1;

SELECT a.*
  FROM service_providers a
 WHERE a.service_provider_code IN ('NewCo')
   AND SYSDATE < NVL(a.expiration_date, SYSDATE + 1)
 ORDER BY 1
;


