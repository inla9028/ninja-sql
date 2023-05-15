SELECT a.subscriber_no, a.additional_title, a.ban
  FROM hgu_tmp_subs_add_title a
;

/*
** Prefix number with GSM047 unless already prefixed.
*/
UPDATE hgu_tmp_subs_add_title a
   SET a.subscriber_no = 'GSM047' || a.subscriber_no
 WHERE a.subscriber_no NOT LIKE 'GSM047%'
;

/*
** Update the BANs from production.
*/
UPDATE hgu_tmp_subs_add_title a
   SET a.ban = (SELECT b.ban FROM billing_account@fokus b, subscriber@fokus s WHERE s.subscriber_no IN (a.subscriber_no) AND s.customer_id = b.ban AND s.sub_status NOT IN ('C'))
;

/*
** List the addresses from Fokus today, without the new additional title.
*/
SELECT 0                              AS "TRANSACTION_NUMBER"
     , 'U'                            AS "LINK_TYPE"
     , h.ban                          AS "BAN_NO"
     , h.subscriber_no                AS "SUBSCRIBER_NO"
     , nd.last_business_name          AS "LAST_BUSINESS_NAME"
     , nd.first_name                  AS "FIRST_NAME"
     , anl.birth_date                 AS "BIRTH_DATE"
     , ad.adr_city                    AS "ADR_CITY"
     , ad.adr_zip                     AS "ADR_ZIP"
     , ad.adr_house_no                AS "ADR_HOUSE_NO"
     , ad.adr_street_name             AS "ADR_STREET_NAME"
     , ad.adr_pob                     AS "ADR_POB"
     , ad.adr_district                AS "ADR_DISTRICT"
     , ad.adr_country                 AS "ADR_COUNTRY"
     , ad.adr_house_letter            AS "ADR_HOUSE_LETTER"
     , ad.adr_story                   AS "ADR_STOREY"
     , ad.adr_door_no                 AS "ADR_DOOR_NO"
     , nd.gender                      AS "ADR_GENDER"
     , s.allow_advertising_ind        AS "ALLOW_ADVERTISING_IND"
     , NULL                           AS "ADR_HOME_PHONE"
     , ad.adr_email                   AS "EMAIL_ADDR"
     , s.listed_ind                   AS "ADR_LISTED_IND"
     , RTRIM(s.publish_level)         AS "PUBLISH_LEVEL"
     , 'ON_HOLD'                      AS "PROCESS_STATUS"
     , NULL                           AS "PROCESS_TIME"
     , NULL                           AS "STATUS_DESC"
     , NULL                           AS "RECORD_CREATION_DATE"
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID"
     , 'NINJA'                        AS "REQUEST_USER_ID"
     , nd.role_ind                    AS "ROLE_IND"
     , NULL                           AS "COMPANY_ID"
     , ad.adr_co_name                 AS "ADR_CO_NAME"
     , NULL                           AS "DSP_IND"
     , h.additional_title             AS "ADDITIONAL_TITLE"
  FROM hgu_tmp_subs_add_title         h
     , address_name_link@fokus        anl
     , name_data@fokus                nd
     , address_data@fokus             ad
     , subscriber@fokus               s
 WHERE h.ban                        = anl.ban
   AND h.subscriber_no              = anl.subscriber_no
   AND SYSDATE                BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND h.ban                        = s.customer_id
   AND h.subscriber_no              = s.subscriber_no
   AND anl.name_id                  = nd.name_id
   AND anl.address_id               = ad.address_id
   AND anl.link_type                = 'U'
;

/*
** Insert the existing names with the updated title.
*/
INSERT INTO ninjadata.batch_name_address_update
SELECT 0                              AS "TRANSACTION_NUMBER"
     , 'U'                            AS "LINK_TYPE"
     , h.ban                          AS "BAN_NO"
     , h.subscriber_no                AS "SUBSCRIBER_NO"
     , nd.last_business_name          AS "LAST_BUSINESS_NAME"
     , nd.first_name                  AS "FIRST_NAME"
     , anl.birth_date                 AS "BIRTH_DATE"
     , ad.adr_city                    AS "ADR_CITY"
     , ad.adr_zip                     AS "ADR_ZIP"
     , ad.adr_house_no                AS "ADR_HOUSE_NO"
     , ad.adr_street_name             AS "ADR_STREET_NAME"
     , ad.adr_pob                     AS "ADR_POB"
     , ad.adr_district                AS "ADR_DISTRICT"
     , ad.adr_country                 AS "ADR_COUNTRY"
     , ad.adr_house_letter            AS "ADR_HOUSE_LETTER"
     , ad.adr_story                   AS "ADR_STOREY"
     , ad.adr_door_no                 AS "ADR_DOOR_NO"
     , nd.gender                      AS "ADR_GENDER"
     , s.allow_advertising_ind        AS "ALLOW_ADVERTISING_IND"
     , NULL                           AS "ADR_HOME_PHONE"
     , ad.adr_email                   AS "EMAIL_ADDR"
     , s.listed_ind                   AS "ADR_LISTED_IND"
     , RTRIM(s.publish_level)         AS "PUBLISH_LEVEL"
     , 'ON_HOLD'                      AS "PROCESS_STATUS"
     , NULL                           AS "PROCESS_TIME"
     , NULL                           AS "STATUS_DESC"
     , NULL                           AS "RECORD_CREATION_DATE"
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID"
     , 'NINJA'                        AS "REQUEST_USER_ID"
     , nd.role_ind                    AS "ROLE_IND"
     , NULL                           AS "COMPANY_ID"
     , ad.adr_co_name                 AS "ADR_CO_NAME"
     , NULL                           AS "DSP_IND"
     , h.additional_title             AS "ADDITIONAL_TITLE"
  FROM hgu_tmp_subs_add_title         h
     , address_name_link@fokus        anl
     , name_data@fokus                nd
     , address_data@fokus             ad
     , subscriber@fokus               s
 WHERE h.ban                        = anl.ban
   AND h.subscriber_no              = anl.subscriber_no
   AND SYSDATE                BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND h.ban                        = s.customer_id
   AND h.subscriber_no              = s.subscriber_no
   AND anl.name_id                  = nd.name_id
   AND anl.address_id               = ad.address_id
   AND anl.link_type                = 'U'
;

/*
** List inserted records.
*/
SELECT a.*
  FROM ninjadata.batch_name_address_update a
 WHERE a.request_id      = TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND a.request_user_id = 'NINJA'
   AND a.process_status  = 'PRSD_ERROR'
;

/*
** Update records after verification.
*/
UPDATE ninjadata.batch_name_address_update a
   SET a.process_status  = 'WAITING'
 WHERE a.request_id      = TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND a.request_user_id = 'NINJA'
   AND a.process_status  = 'ON_HOLD'
;

/*
** Once processed, list the result.
*/
SELECT a.subscriber_no, a.ban_no, a.additional_title, a.process_status,
       REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (a.status_desc,
                           0,
                           INSTR (a.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (a.status_desc,
                               0,
                               INSTR (a.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM ninjadata.batch_name_address_update a
 WHERE a.request_id      = TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND a.request_user_id = 'NINJA'
ORDER BY a.process_status, a.subscriber_no, a.ban_no
;

/*
** Re-process records that failed due to a temporary error.
*/
UPDATE ninjadata.batch_name_address_update a
  SET a.process_status   = 'WAITING'
    , a.process_time     = NULL
    , a.status_desc      = NULL
 WHERE a.request_id      = TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND a.request_user_id = 'NINJA'
    AND a.process_status = 'PRSD_ERROR'
    AND (
         a.status_desc LIKE '%has been changed since last retrieved%'
      OR a.status_desc LIKE '%Ban has been updated since last retrieved%'
      OR a.status_desc LIKE '%Please try accessing account again later%'
      OR a.status_desc LIKE 'Attempting to assign Default Fokus User but encountered a null value%'
      OR a.status_desc LIKE 'Tuxedo system exception occurred during the execution of the Tuxedo service%'
      OR a.status_desc LIKE '%ConcurrentModificationException%'
      OR a.status_desc LIKE '%NinjaBusinessRulesException%'
    )
;
