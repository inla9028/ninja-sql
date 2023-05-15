DELETE
  FROM tmp_addresses_invalid_w_names
;

--CREATE TABLE tmp_addresses_invalid_w_names
--AS
INSERT INTO tmp_addresses_invalid_w_names
SELECT a.*
  FROM tmp_addresses_w_names a
 WHERE TRIM(a.adr_country)          = 'NOR' 
   AND LENGTH(a.first_name)         > 1
   AND LENGTH(a.last_business_name) > 1
   AND a.subscriber_no              LIKE 'GSM%'
--   AND a.birth_date                 IS NOT NULL
   AND 0                            = (SELECT COUNT(1)
                                         FROM zip_decode z
                                        WHERE a.adr_zip         = z.zip_code
                                          AND UPPER(a.adr_city) = z.city)
;

INSERT INTO tmp_addresses_invalid_w_names
SELECT a.*
  FROM tmp_addresses_w_names a
 WHERE TRIM(a.adr_country)          = 'NOR' 
   AND LENGTH(a.first_name)         > 1
   AND LENGTH(a.last_business_name) > 1
   AND a.subscriber_no              LIKE '000%'
--   AND a.birth_date                 IS NOT NULL
   AND 0                            = (SELECT COUNT(1)
                                         FROM zip_decode z
                                        WHERE a.adr_zip         = z.zip_code
                                          AND UPPER(a.adr_city) = z.city)
;

COMMIT WORK
;

SELECT COUNT(1) AS "ADR_COUNT"
  FROM tmp_addresses_invalid_w_names
;