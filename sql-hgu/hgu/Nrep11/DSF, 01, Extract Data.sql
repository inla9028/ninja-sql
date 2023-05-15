/*
** Note:
** Name Format.: D = Company, P = Private.
** Address Type: R = Regular, P = PO.Box
*/

DELETE
  FROM hgu_dsf_wash
;

--
-- BAN
--
INSERT INTO hgu_dsf_wash
SELECT 'DSF 2021-10-28'                  AS "OPPDRAGSID"
     , NULL                              AS "EGEN_ID"
     , to_char(nd.birth_date, 'DDMMYY')  AS "FODSELSDATO"
     , NULL                              AS "PERSONNR"
     , substr(nd.last_business_name, 0, 50) AS "NAVN" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."NAVN" (actual: 54, maximum: 50)
     , decode(nd.name_format
            , 'D', NULL
            , substr(nd.first_name, 0, 50))      AS "FORNAVN"
     , decode(ad.adr_type
            , 'P', 'Postboks ' || ad.adr_pob
            , substr(ad.adr_street_name, 0, 30)) AS "ADRESSE" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."ADRESSE" (actual: 31, maximum: 30)
     , decode(LENGTH(ad.adr_house_no)
            , 1, adr_house_no
            , 2, adr_house_no
            , 3, adr_house_no
            , 4, adr_house_no
            , NULL)                      AS "HUSNR"
     , decode(LENGTH(ad.adr_zip)
            , 4, ad.adr_zip
            , NULL)                      AS "POSTNR" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."POSTNR" (actual: 8, maximum: 4)
     , NULL                              AS "SYSTEM_DATA"
     --
     , anl.ban
     , NULL                              AS "SUBSCRIBER_NO"
     , anl.link_type
     , anl.address_id
     , ad.adr_type
     , anl.name_id
     , nd.name_format
     , NULL                              AS "PROCESS_STATUS"
  FROM address_name_link anl
     , billing_account   ba
     , address_data      ad
     , name_data         nd
 WHERE SYSDATE BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
   AND anl.ban          = ba.ban
   AND ba.account_type NOT IN ( 'B', 'P', 'S' )
   AND ba.ban_status   IN ( 'O', 'S' )
   AND anl.link_type   IN ( 'B', 'L')
--   AND ROWNUM           < 21
   AND ad.address_id    = anl.address_id
--   AND ad.adr_type      = 'P' -- Regular  -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."HUSNR" (actual: 13, maximum: 4)
--   AND ad.adr_country   = 'NOR' -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."POSTNR" (actual: 5, maximum: 4)
   AND nd.name_id       = anl.name_id
ORDER BY anl.ban, anl.link_type, anl.name_id
;

COMMIT WORK
;

--
-- BAN Prepaid, we need to filter out the invalid (KONTANT) addresses afterwards.
--
INSERT INTO hgu_dsf_wash
SELECT 'DSF 2021-10-28'                  AS "OPPDRAGSID"
     , NULL                              AS "EGEN_ID"
     , to_char(nd.birth_date, 'DDMMYY')  AS "FODSELSDATO"
     , NULL                              AS "PERSONNR"
     , substr(nd.last_business_name, 0, 50) AS "NAVN" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."NAVN" (actual: 54, maximum: 50)
     , decode(nd.name_format
            , 'D', NULL
            , substr(nd.first_name, 0, 50))      AS "FORNAVN"
     , decode(ad.adr_type
            , 'P', 'Postboks ' || ad.adr_pob
            , substr(ad.adr_street_name, 0, 30)) AS "ADRESSE" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."ADRESSE" (actual: 31, maximum: 30)
     , decode(LENGTH(ad.adr_house_no)
            , 1, adr_house_no
            , 2, adr_house_no
            , 3, adr_house_no
            , 4, adr_house_no
            , NULL)                      AS "HUSNR"
     , decode(LENGTH(ad.adr_zip)
            , 4, ad.adr_zip
            , NULL)                      AS "POSTNR" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."POSTNR" (actual: 8, maximum: 4)
     , NULL                              AS "SYSTEM_DATA"
     --
     , anl.ban
     , NULL                              AS "SUBSCRIBER_NO"
     , anl.link_type
     , anl.address_id
     , ad.adr_type
     , anl.name_id
     , nd.name_format
     , NULL                              AS "PROCESS_STATUS"
  FROM address_name_link anl
     , billing_account   ba
     , address_data      ad
     , name_data         nd
 WHERE SYSDATE BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
   AND anl.ban                = ba.ban
   AND ba.account_type       IN ( 'P' )
   AND ba.ban_status         IN ( 'O', 'S' )
   AND anl.link_type         IN ( 'L')
--   AND ROWNUM           < 21
   AND ad.address_id          = anl.address_id
   AND nd.name_id             = anl.name_id
   AND nd.first_name         != 'BRUKER'
   AND nd.last_business_name != 'KONTANT'
ORDER BY anl.ban, anl.link_type, anl.name_id
;

COMMIT WORK
;

--
-- Subscriptions, regular ones.
--
INSERT INTO hgu_dsf_wash
SELECT 'DSF 2021-10-28'                  AS "OPPDRAGSID"
     , NULL                              AS "EGEN_ID"
     , to_char(nd.birth_date, 'DDMMYY')  AS "FODSELSDATO"
     , NULL                              AS "PERSONNR"
     , substr(nd.last_business_name, 0, 50) AS "NAVN" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."NAVN" (actual: 54, maximum: 50)
     , decode(nd.name_format
            , 'D', NULL
            , substr(nd.first_name, 0, 50))      AS "FORNAVN"
     , decode(ad.adr_type
            , 'P', 'Postboks ' || ad.adr_pob
            , substr(ad.adr_street_name, 0, 30)) AS "ADRESSE" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."ADRESSE" (actual: 31, maximum: 30)
     , decode(LENGTH(ad.adr_house_no)
            , 1, adr_house_no
            , 2, adr_house_no
            , 3, adr_house_no
            , 4, adr_house_no
            , NULL)                      AS "HUSNR"
     , decode(LENGTH(ad.adr_zip)
            , 4, ad.adr_zip
            , NULL)                      AS "POSTNR" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."POSTNR" (actual: 8, maximum: 4)
     , NULL                              AS "SYSTEM_DATA"
     --
     , anl.ban
     , anl.subscriber_no                 AS "SUBSCRIBER_NO"
     , anl.link_type
     , anl.address_id
     , ad.adr_type
     , anl.name_id
     , nd.name_format
     , NULL                              AS "PROCESS_STATUS"
  FROM address_name_link anl
     , billing_account   ba
     , subscriber        s
     , address_data      ad
     , name_data         nd
 WHERE SYSDATE BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
   AND anl.ban          = ba.ban
   AND ba.account_type NOT IN ( 'B', 'P', 'S' )
   AND s.customer_id    = ba.ban
   AND s.subscriber_no  = anl.subscriber_no
   AND s.sub_status    IN ( 'A', 'S' )
   AND anl.link_type   IN ( 'U' )
--   AND ROWNUM           < 21
   AND ad.address_id    = anl.address_id
--   AND ad.adr_type      = 'P' -- Regular  -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."HUSNR" (actual: 13, maximum: 4)
--   AND ad.adr_country   = 'NOR' -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."POSTNR" (actual: 5, maximum: 4)
   AND nd.name_id       = anl.name_id
ORDER BY anl.ban, anl.link_type, anl.name_id
;

COMMIT WORK
;

--
-- Subscriptions, B/HI...
--
INSERT INTO hgu_dsf_wash
SELECT 'DSF 2021-10-28'                  AS "OPPDRAGSID"
     , NULL                              AS "EGEN_ID"
     , to_char(nd.birth_date, 'DDMMYY')  AS "FODSELSDATO"
     , NULL                              AS "PERSONNR"
     , substr(nd.last_business_name, 0, 50) AS "NAVN" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."NAVN" (actual: 54, maximum: 50)
     , decode(nd.name_format
            , 'D', NULL
            , substr(nd.first_name, 0, 50))      AS "FORNAVN"
     , decode(ad.adr_type
            , 'P', 'Postboks ' || ad.adr_pob
            , substr(ad.adr_street_name, 0, 30)) AS "ADRESSE" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."ADRESSE" (actual: 31, maximum: 30)
     , decode(LENGTH(ad.adr_house_no)
            , 1, adr_house_no
            , 2, adr_house_no
            , 3, adr_house_no
            , 4, adr_house_no
            , NULL)                      AS "HUSNR"
     , decode(LENGTH(ad.adr_zip)
            , 4, ad.adr_zip
            , NULL)                      AS "POSTNR" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."POSTNR" (actual: 8, maximum: 4)
     , NULL                              AS "SYSTEM_DATA"
     --
     , anl.ban
     , anl.subscriber_no                 AS "SUBSCRIBER_NO"
     , anl.link_type
     , anl.address_id
     , ad.adr_type
     , anl.name_id
     , nd.name_format
     , NULL                              AS "PROCESS_STATUS"
  FROM address_name_link anl
     , billing_account   ba
     , subscriber        s
     , address_data      ad
     , name_data         nd
 WHERE SYSDATE BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
   AND anl.ban              = ba.ban
   AND ba.account_type     IN ( 'B' )
   AND ba.account_sub_type IN ( 'HI' )
   AND s.customer_id        = ba.ban
   AND s.subscriber_no      = anl.subscriber_no
   AND s.sub_status        IN ( 'A', 'S' )
   AND anl.link_type       IN ( 'U' )
--   AND ROWNUM               < 21
   AND ad.address_id        = anl.address_id
--   AND ad.adr_type          = 'P' -- Regular  -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."HUSNR" (actual: 13, maximum: 4)
--   AND ad.adr_country       = 'NOR' -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."POSTNR" (actual: 5, maximum: 4)
   AND nd.name_id       = anl.name_id
ORDER BY anl.ban, anl.link_type, anl.name_id
;

COMMIT WORK
;

--
-- Subscriptions, Prepaid...
--
INSERT INTO hgu_dsf_wash
SELECT 'DSF 2021-10-28'                  AS "OPPDRAGSID"
     , NULL                              AS "EGEN_ID"
     , to_char(nd.birth_date, 'DDMMYY')  AS "FODSELSDATO"
     , NULL                              AS "PERSONNR"
     , substr(nd.last_business_name, 0, 50) AS "NAVN" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."NAVN" (actual: 54, maximum: 50)
     , decode(nd.name_format
            , 'D', NULL
            , substr(nd.first_name, 0, 50))      AS "FORNAVN"
     , decode(ad.adr_type
            , 'P', 'Postboks ' || ad.adr_pob
            , substr(ad.adr_street_name, 0, 30)) AS "ADRESSE" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."ADRESSE" (actual: 31, maximum: 30)
     , decode(LENGTH(ad.adr_house_no)
            , 1, adr_house_no
            , 2, adr_house_no
            , 3, adr_house_no
            , 4, adr_house_no
            , NULL)                      AS "HUSNR"
     , decode(LENGTH(ad.adr_zip)
            , 4, ad.adr_zip
            , NULL)                      AS "POSTNR" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."POSTNR" (actual: 8, maximum: 4)
     , NULL                              AS "SYSTEM_DATA"
     --
     , anl.ban
     , anl.subscriber_no                 AS "SUBSCRIBER_NO"
     , anl.link_type
     , anl.address_id
     , ad.adr_type
     , anl.name_id
     , nd.name_format
     , NULL                              AS "PROCESS_STATUS"
  FROM address_name_link anl
     , billing_account   ba
     , subscriber        s
     , address_data      ad
     , name_data         nd
 WHERE SYSDATE         BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
   AND anl.ban               = ba.ban
   AND ba.account_type      IN ( 'P' )
   AND s.customer_id         = ba.ban
   AND s.subscriber_no       = anl.subscriber_no
   AND s.sub_status         IN ( 'A', 'S' )
   AND anl.link_type        IN ( 'U' )
--   AND ROWNUM                < 21
   AND ad.address_id         = anl.address_id
--   AND ad.adr_type           = 'P' -- Regular  -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."HUSNR" (actual: 13, maximum: 4)
--   AND ad.adr_country        = 'NOR' -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."POSTNR" (actual: 5, maximum: 4)
   AND nd.name_id            = anl.name_id
   AND nd.first_name         != 'BRUKER'
   AND nd.last_business_name != 'KONTANT'
ORDER BY anl.ban, anl.link_type, anl.name_id
;

COMMIT WORK
;

--
-- Subscriptions, B, not HI...
--
INSERT INTO hgu_dsf_wash
SELECT 'DSF 2021-10-28'                  AS "OPPDRAGSID"
     , NULL                              AS "EGEN_ID"
     , to_char(nd.birth_date, 'DDMMYY')  AS "FODSELSDATO"
     , NULL                              AS "PERSONNR"
     , substr(nd.last_business_name, 0, 50) AS "NAVN" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."NAVN" (actual: 54, maximum: 50)
     , decode(nd.name_format
            , 'D', NULL
            , substr(nd.first_name, 0, 50))      AS "FORNAVN"
     , decode(ad.adr_type
            , 'P', 'Postboks ' || ad.adr_pob
            , substr(ad.adr_street_name, 0, 30)) AS "ADRESSE" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."ADRESSE" (actual: 31, maximum: 30)
     , decode(LENGTH(ad.adr_house_no)
            , 1, adr_house_no
            , 2, adr_house_no
            , 3, adr_house_no
            , 4, adr_house_no
            , NULL)                      AS "HUSNR"
     , decode(LENGTH(ad.adr_zip)
            , 4, ad.adr_zip
            , NULL)                      AS "POSTNR" -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."POSTNR" (actual: 8, maximum: 4)
     , NULL                              AS "SYSTEM_DATA"
     --
     , anl.ban
     , anl.subscriber_no                 AS "SUBSCRIBER_NO"
     , anl.link_type
     , anl.address_id
     , ad.adr_type
     , anl.name_id
     , nd.name_format
     , NULL                              AS "PROCESS_STATUS"
  FROM address_name_link anl
     , billing_account   ba
     , subscriber        s
     , address_data      ad
     , name_data         nd
 WHERE SYSDATE BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
   AND anl.ban              = ba.ban
   AND ba.account_type     IN ( 'B' )
   AND ba.account_sub_type NOT IN ( 'HI' )
   AND s.customer_id        = ba.ban
   AND s.subscriber_no      = anl.subscriber_no
   AND s.sub_status        IN ( 'A', 'S' )
   AND anl.link_type       IN ( 'U' )
--   AND ROWNUM               < 21
   AND ad.address_id        = anl.address_id
--   AND ad.adr_type          = 'P' -- Regular  -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."HUSNR" (actual: 13, maximum: 4)
--   AND ad.adr_country       = 'NOR' -- ORA-12899: value too large for column "NINJA"."HGU_DSF_WASH"."POSTNR" (actual: 5, maximum: 4)
   AND nd.name_id       = anl.name_id
   AND nd.name_format   = 'P' -- P = Private, D = Company
ORDER BY anl.ban, anl.link_type, anl.name_id
;

COMMIT WORK
;

DELETE
  FROM hgu_dsf_wash A
 WHERE A.adresse  = 'SANDAKERVEIEN'
   AND (A.navn    IN ( '.', ',', ';', 'TEST', 'TEST 5G', 'TELIA NORGE AS AVD 0163', 'TELIA AS AVD 3040', 'TELIA AS AVD 440', 'TELIA NORGE AS AVD 5000' )
     OR A.fornavn IN ( '.', ',', ';', 'BRUKER', 'NETCOM', 'TEST', 'TEST ABO', 'TESTABO', 'TELIA', 'Telia' )
     OR (A.navn    IN ( 'MBB',    'SHOPS',   'MIN BEDRIFT PROSJEKT', 'LAB' )
     AND A.fornavn IN ( 'BUTIKK', 'NETGEAR', 'TESBRUKERER',          '5G' ) ) )
;

DELETE
  FROM hgu_dsf_wash a
 WHERE a.adresse  = 'SANDAKERVEIEN'
   AND a.husnr    = '140'
;

DELETE
  FROM hgu_dsf_wash A
 WHERE A.navn    IN ( 'AS',     'GSM AS', 'KONTANT', 'NORGE AS',      'TEST' )
   AND A.fornavn IN ( 'BRUKER', 'FHS',    'NETCOM',  'PETTER NETCOM', 'TELIA' )
;

DELETE
  FROM hgu_dsf_wash A
 WHERE A.postnr         IN ( '0403' )
   AND lower(A.adresse) IN ( 'postboks 4444' )
   AND (A.navn          IN ( 'NETCOM GSM AS', 'TELIASONERA NORGE AS', 'CALLGUIDE' )
     OR A.fornavn       IN ( 'CALLGUIDE', 'TELIA' )
     OR (A.navn IS NULL AND A.fornavn IS NULL))
;

DELETE
  FROM hgu_dsf_wash A
 WHERE A.name_format = 'D'
;

UPDATE hgu_dsf_wash A
   SET A.navn = NULL
 WHERE A.navn IN ('.', ',', ';' )
;

UPDATE hgu_dsf_wash A
   SET A.fornavn = NULL
 WHERE A.fornavn IN ('.', ',', ';' )
;

COMMIT WORK
;

SELECT count(1) AS "COUNT"
  FROM hgu_dsf_wash
;

/*
CREATE TABLE hgu_dsf_wash (
  oppdragsid    VARCHAR2(14 CHAR),
  egen_id       NUMBER(9),
  fodselsdato   VARCHAR2(6 CHAR), -- DDMMÅÅ
  personnr      VARCHAR2(5 CHAR),
  navn          VARCHAR2(50 CHAR),
  fornavn       VARCHAR2(50 CHAR),
  adresse       VARCHAR2(30 CHAR),
  husnr         VARCHAR2(4 CHAR),
  postnr        VARCHAR2(4 CHAR),
  system_data   VARCHAR2(21 CHAR),
  -- The rest are mappings into our data.
  ban           NUMBER(9), 
  subscriber_no VARCHAR2(32 CHAR),
  link_type     VARCHAR2(1 CHAR),
  address_id    NUMBER(9),
  address_type  VARCHAR2(1 CHAR),
  name_id       NUMBER(9),
  name_format   VARCHAR2(1 CHAR),
  process_status VARCHAR2(16 CHAR)
 )
;
*/

--
-- Extract the relevant columns for Evry.
--
SELECT oppdragsid, egen_id, fodselsdato, personnr, navn, fornavn, adresse, husnr, postnr, system_data
  FROM hgu_dsf_wash
-- WHERE name_format = 'P' 
 WHERE oppdragsid = 'DSF 2021-10-28'
ORDER BY ban, link_type, name_id
;

--
-- Extract combined with account-type and comp_reg_id.
SELECT A.*
     , ba.account_type, ba.account_sub_type, nd.tpid, nd.comp_reg_id
  FROM hgu_dsf_wash A, billing_account ba, name_data nd
 WHERE A.oppdragsid = 'DSF 2021-10-28'
   AND A.ban        = ba.ban
   AND A.name_id    = nd.name_id
-- WHERE name_format = 'P' 
--   AND ROWNUM < 21
ORDER BY A.ban, A.link_type, A.name_id
;

--
-- Some statistics.
--
SELECT b.account_type, b.birth_date, count(1) AS "COUNT"
  FROM (SELECT ba.account_type, decode(A.fodselsdato, NULL, 'Without', 'With') AS "BIRTH_DATE"
          FROM hgu_dsf_wash A, billing_account ba
         WHERE A.ban = ba.customer_id
--           AND ROWNUM < 201
           ) b
GROUP BY b.account_type, b.birth_date
ORDER BY b.account_type, b.birth_date
;

SELECT b.account_type, b.link_type, count(1) AS "COUNT"
  FROM (SELECT ba.account_type, a.link_type
          FROM hgu_dsf_wash A, billing_account ba
         WHERE A.ban = ba.customer_id
--           AND ROWNUM < 201
           ) b
GROUP BY b.account_type, b.link_type
ORDER BY b.account_type, b.link_type
;