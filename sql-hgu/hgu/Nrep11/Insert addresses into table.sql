DELETE
  FROM tmp_addresses
;

--CREATE TABLE tmp_addresses
--AS
INSERT INTO tmp_addresses
SELECT /*+ hash(ba,anl) */
       ba.ban,
       anl.subscriber_no,
       anl.link_type,
       ad.address_id,
       ad.adr_city,
       ad.adr_zip,
       RTRIM(ad.adr_country) AS "ADR_COUNTRY",
       ad.adr_secondary_ln,
       ad.sys_creation_date
  FROM billing_account   ba,
       address_name_link anl,
       name_data         nd,
       address_data      ad,
       subscriber        su
 WHERE ba.ban_status          = 'O'
   AND ba.account_type   NOT IN ( 'S', 'H' ) -- S = SP, H = Chess (being phased out and having 15k of invalid birth-dates.
   AND ba.ban                 = anl.ban
   AND anl.subscriber_no      = su.subscriber_no
   AND ba.ban                 = su.customer_id 
   AND su.sub_status         != 'C'
   AND SYSDATE          BETWEEN anl.effective_date AND NVL (anl.expiration_date, SYSDATE + 1)
   AND anl.link_type         IN ( 'U' )
   AND anl.name_id            = nd.name_id
   AND nd.first_name         != 'BRUKER'      -- Prepaid...
   AND nd.last_business_name != 'KONTANT'     -- Prepaid...
   AND anl.address_id         = ad.address_id
   AND RTRIM(ad.adr_country)  = 'NOR'
UNION ALL
SELECT /*+ hash(ba,anl) */
       ba.ban,
       anl.subscriber_no,
       anl.link_type,
       ad.address_id,
       ad.adr_city,
       ad.adr_zip,
       RTRIM(ad.adr_country) AS "ADR_COUNTRY",
       ad.adr_secondary_ln,
       ad.sys_creation_date
  FROM billing_account   ba,
       address_name_link anl,
       name_data         nd,
       address_data      ad
 WHERE ba.ban_status          = 'O'
   AND ba.account_type   NOT IN ( 'S', 'H' ) -- S = SP, H = Chess (being phased out and having 15k of invalid birth-dates.
   AND ba.ban                 = anl.ban
   AND SYSDATE          BETWEEN anl.effective_date AND NVL (anl.expiration_date, SYSDATE + 1)
   AND anl.link_type         IN ( 'B', 'L' )
   AND anl.name_id            = nd.name_id
   AND nd.first_name         != 'BRUKER'      -- Prepaid...
   AND nd.last_business_name != 'KONTANT'     -- Prepaid...
   AND anl.address_id         = ad.address_id
   AND RTRIM(ad.adr_country)  = 'NOR'
;

COMMIT WORK
;

SELECT COUNT(1) AS "ADR_COUNT"
  FROM tmp_addresses
;
