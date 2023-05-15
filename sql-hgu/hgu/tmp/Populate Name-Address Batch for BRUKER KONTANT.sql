--
-- Step 1) List addresses in the format 
--
SELECT anl.link_type, anl.ban AS "BAN_NO"
     , DECODE(anl.subscriber_no, '0000000000', NULL, anl.subscriber_no) AS "SUBSCRIBER_NO"
     , nd.last_business_name, nd.first_name
     , TO_CHAR(anl.birth_date,  'YYYY-MM-DD') AS "BIRTH_DATE"
     , ad.adr_city, ad.adr_zip, ad.adr_house_no, ad.adr_street_name
     , ad.adr_pob, ad.adr_district, ad.adr_country, ad.adr_house_letter
     , ad.adr_story AS "ADR_STOREY", ad.adr_door_no, nd.gender AS "ADR_GENDER"
     , NULL AS "ALLOW_ADVERTISING_IND", NULL AS "ADR_HOME_PHONE"
     , ad.adr_email, NULL AS "ADR_LISTED_IND", NULL AS "PUBLISH_LEVEL"
     , 'WAITING' AS "PROCESS_STATUS", NULL AS "PROCESS_TIME"
     , NULL AS "STATUS_DESC", NULL AS "RECORD_CREATION_DATE"
     , '2016-04-07' AS "REQUEST_ID", 'KEJE0029' AS "REQUEST_USER_ID"
     , NULL AS "ROLE_IND", NULL AS "COMPANY_ID", ad.adr_co_name AS "ADR_CO_NAME"
     , nd.additional_title
  FROM address_name_link anl, name_data nd, address_data ad, subscriber s
 WHERE anl.ban           = s.customer_id
   AND s.subscriber_no  IN (
      'GSM04745495213', 'GSM04792494803', 'GSM04798848874', 'GSM04747222260', 'GSM04745471051', 'GSM04791124688', 'GSM04798425308', 'GSM04793423401', 'GSM04793880494'
    , 'GSM04792602492', 'GSM04798695490', 'GSM04798768502', 'GSM04792804932', 'GSM04798175202', 'GSM04798327624', 'GSM04745449235', 'GSM04745279604', 'GSM04745267453'
    , 'GSM04740488410', 'GSM04795254961', 'GSM04792614853', 'GSM04798309383', 'GSM04745475486', 'GSM04793802493', 'GSM04798993731', 'GSM04798198248', 'GSM04798329754'
    , 'GSM04740782429', 'GSM04740469022', 'GSM04798665536', 'GSM04798668047', 'GSM04798639512', 'GSM04798693687', 'GSM04793271937', 'GSM04792698290', 'GSM04740718123'
    , 'GSM04798413862', 'GSM04793600840', 'GSM04797570149', 'GSM04798872892', 'GSM04793863577', 'GSM04798301730', 'GSM04740718500', 'GSM04792041913', 'GSM04798053544'
    , 'GSM04798179518'
   )
   AND s.sub_status      = 'A'
   AND SYSDATE     BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id       = nd.name_id
   AND anl.address_id    = ad.address_id
ORDER BY anl.ban, anl.link_type
;

--
-- Step 2) List addresses where the last name is BRUKER and first name is KONTANT,
--         but use the name/address from the address where it's not.
--
SELECT anl.link_type, anl.ban AS "BAN_NO"
     , DECODE(anl.subscriber_no, '0000000000', NULL, anl.subscriber_no) AS "SUBSCRIBER_NO"
     , nd2.last_business_name, nd2.first_name
     , TO_CHAR(anl2.birth_date,  'YYYY-MM-DD') AS "BIRTH_DATE"
     , ad2.adr_city, ad2.adr_zip, ad2.adr_house_no, ad2.adr_street_name
     , ad2.adr_pob, ad2.adr_district, ad2.adr_country, ad2.adr_house_letter
     , ad2.adr_story AS "ADR_STOREY", ad2.adr_door_no, nd2.gender AS "ADR_GENDER"
     , NULL AS "ALLOW_ADVERTISING_IND", NULL AS "ADR_HOME_PHONE"
     , NULL AS "ADR_EMAIL", NULL AS "ADR_LISTED_IND", NULL AS "PUBLISH_LEVEL"
     , 'WAITING' AS "PROCESS_STATUS", NULL AS "PROCESS_TIME"
     , NULL AS "STATUS_DESC", NULL AS "RECORD_CREATION_DATE"
     , '2016-04-07' AS "REQUEST_ID", 'KEJE0029' AS "REQUEST_USER_ID"
     , NULL AS "ROLE_IND", NULL AS "COMPANY_ID", ad2.adr_co_name AS "ADR_CO_NAME"
     , nd.additional_title
  FROM address_name_link anl, name_data nd, address_data ad, subscriber s
     , address_name_link anl2, name_data nd2, address_data ad2
 WHERE anl.ban           = s.customer_id
   AND s.subscriber_no  IN (
      'GSM04745495213', 'GSM04792494803', 'GSM04798848874', 'GSM04747222260', 'GSM04745471051', 'GSM04791124688', 'GSM04798425308', 'GSM04793423401', 'GSM04793880494'
    , 'GSM04792602492', 'GSM04798695490', 'GSM04798768502', 'GSM04792804932', 'GSM04798175202', 'GSM04798327624', 'GSM04745449235', 'GSM04745279604', 'GSM04745267453'
    , 'GSM04740488410', 'GSM04795254961', 'GSM04792614853', 'GSM04798309383', 'GSM04745475486', 'GSM04793802493', 'GSM04798993731', 'GSM04798198248', 'GSM04798329754'
    , 'GSM04740782429', 'GSM04740469022', 'GSM04798665536', 'GSM04798668047', 'GSM04798639512', 'GSM04798693687', 'GSM04793271937', 'GSM04792698290', 'GSM04740718123'
    , 'GSM04798413862', 'GSM04793600840', 'GSM04797570149', 'GSM04798872892', 'GSM04793863577', 'GSM04798301730', 'GSM04740718500', 'GSM04792041913', 'GSM04798053544'
    , 'GSM04798179518'
   )
   AND s.sub_status      = 'A'
   AND SYSDATE     BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id       = nd.name_id
   AND anl.address_id    = ad.address_id
   AND anl.ban           = anl2.ban
   AND SYSDATE     BETWEEN anl2.effective_date AND NVL(anl2.expiration_date, SYSDATE + 1)
   AND anl2.name_id       = nd2.name_id
   AND anl2.address_id    = ad2.address_id
   AND anl.name_id       != anl2.name_id
   AND anl.address_id    != anl2.address_id
   AND nd.last_business_name = 'KONTANT'
   AND nd.first_name         = 'BRUKER' 
   AND nd2.last_business_name != 'KONTANT'
   AND nd2.first_name         != 'BRUKER'
   AND anl.link_type         != anl2.link_type
ORDER BY anl.ban, anl.link_type
;

--
-- Step 1) List addresses in the format
-- BAN
--
SELECT anl.link_type, anl.ban AS "BAN_NO"
     , DECODE(anl.subscriber_no, '0000000000', NULL, anl.subscriber_no) AS "SUBSCRIBER_NO"
     , nd.last_business_name, nd.first_name
     , TO_CHAR(anl.birth_date,  'YYYY-MM-DD') AS "BIRTH_DATE"
     , ad.adr_city, ad.adr_zip, ad.adr_house_no, ad.adr_street_name
     , ad.adr_pob, ad.adr_district, ad.adr_country, ad.adr_house_letter
     , ad.adr_story AS "ADR_STOREY", ad.adr_door_no, nd.gender AS "ADR_GENDER"
     , NULL AS "ALLOW_ADVERTISING_IND", NULL AS "ADR_HOME_PHONE"
     , ad.adr_email, NULL AS "ADR_LISTED_IND", NULL AS "PUBLISH_LEVEL"
     , 'WAITING' AS "PROCESS_STATUS", NULL AS "PROCESS_TIME"
     , NULL AS "STATUS_DESC", NULL AS "RECORD_CREATION_DATE"
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID", 'KEJE0029' AS "REQUEST_USER_ID"
     , NULL AS "ROLE_IND", NULL AS "COMPANY_ID", ad.adr_co_name AS "ADR_CO_NAME"
     , nd.additional_title
  FROM address_name_link anl, name_data nd, address_data ad
 WHERE anl.ban          IN (
      531158210, 861948214
   )
   AND SYSDATE     BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id       = nd.name_id
   AND anl.address_id    = ad.address_id
ORDER BY anl.ban, anl.link_type
;

--
-- Step 2) List addresses where the last name is BRUKER and first name is KONTANT,
--         but use the name/address from the address where it's not.
-- BAN
--
SELECT anl.link_type, anl.ban AS "BAN_NO"
     , DECODE(anl.subscriber_no, '0000000000', NULL, anl.subscriber_no) AS "SUBSCRIBER_NO"
     , nd2.last_business_name, nd2.first_name
     , TO_CHAR(anl2.birth_date,  'YYYY-MM-DD') AS "BIRTH_DATE"
     , ad2.adr_city, ad2.adr_zip, ad2.adr_house_no, ad2.adr_street_name
     , ad2.adr_pob, ad2.adr_district, ad2.adr_country, ad2.adr_house_letter
     , ad2.adr_story AS "ADR_STOREY", ad2.adr_door_no, nd2.gender AS "ADR_GENDER"
     , NULL AS "ALLOW_ADVERTISING_IND", NULL AS "ADR_HOME_PHONE"
     , NULL AS "ADR_EMAIL", NULL AS "ADR_LISTED_IND", NULL AS "PUBLISH_LEVEL"
     , 'WAITING' AS "PROCESS_STATUS", NULL AS "PROCESS_TIME"
     , NULL AS "STATUS_DESC", NULL AS "RECORD_CREATION_DATE"
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID", 'KEJE0029' AS "REQUEST_USER_ID"
     , NULL AS "ROLE_IND", NULL AS "COMPANY_ID", ad2.adr_co_name AS "ADR_CO_NAME"
     , nd.additional_title
  FROM address_name_link anl, name_data nd, address_data ad
     , address_name_link anl2, name_data nd2, address_data ad2
 WHERE anl.ban          IN (
      640058210, 114548217, 989748215, 463948216, 499748218, 399748219
    , 174158212, 274848217, 473767218, 379848211, 732948211, 131787210, 583948211
   )
   AND SYSDATE     BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id       = nd.name_id
   AND anl.address_id    = ad.address_id
   AND anl.ban           = anl2.ban
   AND SYSDATE     BETWEEN anl2.effective_date AND NVL(anl2.expiration_date, SYSDATE + 1)
   AND anl2.name_id       = nd2.name_id
   AND anl2.address_id    = ad2.address_id
   AND anl.name_id       != anl2.name_id
   AND anl.address_id    != anl2.address_id
   AND nd.last_business_name = 'KONTANT'
   AND nd.first_name         = 'BRUKER' 
   AND nd2.last_business_name != 'KONTANT'
   AND nd2.first_name         != 'BRUKER'
   AND anl.link_type         != anl2.link_type
ORDER BY anl.ban, anl.link_type
;

