DELETE
  FROM tmp_addresses_street
;


--CREATE TABLE tmp_addresses_street
--AS
INSERT INTO tmp_addresses_street
SELECT /*+ hash(ba,anl) */
       anl.ban, anl.subscriber_no, anl.link_type
     , nd.name_format, nd.role_ind, nd.first_name, nd.last_business_name
     , ad.adr_type, ad.adr_pob, ad.adr_street_name, ad.adr_house_no, ad.adr_house_letter, ad.adr_zip, ad.adr_city, RTRIM(ad.adr_country) AS "ADR_COUNTRY"
  FROM tmp_bans_w_account_type   ba,
       address_name_link anl,
       name_data         nd,
       address_data      ad,
       subscriber        su
 WHERE ba.ban                 = anl.ban
   AND anl.subscriber_no      = su.subscriber_no
   AND ba.ban                 = su.customer_id 
   AND su.sub_status         IN ( 'A', 'R', 'S' )
   AND SYSDATE          BETWEEN anl.effective_date AND NVL (anl.expiration_date, SYSDATE + 1)
   AND anl.link_type         IN ( 'U' )
   AND anl.name_id            = nd.name_id
--   AND nd.first_name         != 'BRUKER'      -- Prepaid...
--   AND nd.last_business_name != 'KONTANT'     -- Prepaid...
   AND anl.address_id         = ad.address_id
   AND RTRIM(ad.adr_country)  = 'NOR'
UNION ALL
SELECT /*+ hash(ba,anl) */
       anl.ban, anl.subscriber_no, anl.link_type
     , nd.name_format, nd.role_ind, nd.first_name, nd.last_business_name
     , ad.adr_type, ad.adr_pob, ad.adr_street_name, ad.adr_house_no, ad.adr_house_letter, ad.adr_zip, ad.adr_city, RTRIM(ad.adr_country) AS "ADR_COUNTRY"
  FROM tmp_bans_w_account_type   ba,
       address_name_link anl,
       name_data         nd,
       address_data      ad
 WHERE ba.ban                 = anl.ban
   AND SYSDATE          BETWEEN anl.effective_date AND NVL (anl.expiration_date, SYSDATE + 1)
   AND anl.link_type         IN ( 'B', 'L' )
   AND anl.name_id            = nd.name_id
--   AND nd.first_name         != 'BRUKER'      -- Prepaid...
--   AND nd.last_business_name != 'KONTANT'     -- Prepaid...
   AND anl.address_id         = ad.address_id
   AND rtrim(ad.adr_country)  = 'NOR'
;


COMMIT WORK
;

SELECT COUNT(1) AS "ADR_COUNT"
  FROM tmp_addresses_street
;

SELECT A.*
  FROM tmp_addresses_street A
 WHERE ROWNUM < 11
;

SELECT b.link_type, b.name_format, b.adr_type, count(1) AS "COUNT"
  FROM (SELECT A.link_type, A.name_format, A.adr_type, a.adr_street_name
          FROM tmp_addresses_street A
         WHERE ROWNUM < 10001) b
 WHERE b.adr_street_name IS NULL
GROUP BY b.link_type, b.name_format, b.adr_type
ORDER BY b.link_type, b.name_format, b.adr_type
;
