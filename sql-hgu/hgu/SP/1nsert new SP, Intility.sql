/*
** Inserts for a new SP + Dealer which may not access any others subscriptions.
*/

INSERT INTO dealers
SELECT 'SP08' AS "DEALER_CODE", 'REGULAR' AS "DEALER_GROUP"
  FROM dual 
 WHERE 1 = 1
;

SELECT a.*
  FROM dealers a
 WHERE a.dealer_code IN ('SP08')
ORDER BY 1
;


INSERT INTO channels
SELECT 'Intility'            AS "CHANNEL_CODE"
     , 'Intility SP Channel' AS "CHANNEL_DESC"
     , 'Y'                AS "DEFAULT_MAN_IND"
     , 'SP08'             AS "DEFAULT_DEALER_CODE"
  FROM dual
 WHERE 1 = 1
;

SELECT a.*
  FROM channels a
 WHERE a.channel_code IN ('Intility')
ORDER BY 1
;


INSERT INTO ninja_user
SELECT 'Intility'     AS "USERNAME"
     , 'Intility'     AS "DEFAULT_CHANNEL_CODE"
     , 'NINJA_SP'     AS "CONTACT_ID"
  FROM dual
 WHERE  1 = 1
;

SELECT a.*
  FROM ninja_user a
 WHERE a.username IN ('Intility')
ORDER BY 1
;


INSERT INTO service_providers
SELECT 'Intility'                 AS "SERVICE_PROVIDER_CODE"
     , 999999999                  AS "ROOT_BAN"
     , 111111111                  AS "CURRENT_ACTIVE_BAN"
     , 250                        AS "MAX_SUBSCRIPTIONS"
     , 'SP08'                     AS "DEALER_CODE"
     , 'I'                        AS "SHORT_NAME"
     , 'NO'                       AS "LANGUAGE_CODE"
     , 'IN'                       AS "BAN_SUB_TYPE"
     , '749'                      AS "OPERATOR_CODE"
     , 'Intility'                 AS "LAST_BUSINESS_NAME"
     , 'Subscriber'               AS "FIRST_NAME"
     , 'NOR'                      AS "ADR_COUNTRY"
     , '0191'                     AS "ADR_ZIP"
     , 'Schweigaards gate 39'     AS "ADR_STREET_NAME"
     , 'Oslo'                     AS "ADR_CITY"
     , NULL                       AS "ADR_HOUSE_LETTER"
     , NULL                       AS "ADR_HOUSE_NO"
     , NULL                       AS "ADR_DOOR_NO"
     , NULL                       AS "ADR_STORY"
     , NULL                       AS "ADR_EMAIL"
     , '84'                       AS "PHYSICAL_HLR_CD"
     , 50                         AS "MIN_NO_OF_ACTIVATION_BANS"
     , NULL                       AS "BAN_STRUCTURE_IND"
     , NULL                       AS "MAX_SUBS_PER_TREE"
     , NULL                       AS "EXPIRATION_DATE"
     , NULL                       AS "BILL_CYCLE"
  FROM dual a
 WHERE 1 = 1
;

/*
** In case the above was a dummy-insert, to enable token-access to SPM,
** update the relevant fields here.
*/
UPDATE service_providers a
   SET a.dealer_code           = 'SP08'    -- OK
     , a.ban_sub_type          = 'IN'      -- OK
     , a.physical_hlr_cd       = '84'      -- OK
     , a.root_ban              = 386435416 -- OK
     , a.current_active_ban    = 486435415 -- OK
 WHERE a.service_provider_code = 'Intility'
;

SELECT a.*
  FROM service_providers a
 WHERE a.service_provider_code IN ('Intility')
   AND SYSDATE < NVL(a.expiration_date, SYSDATE + 1)
 ORDER BY 1
;


