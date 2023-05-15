DELETE
  FROM tmp_addresses_invalid
;

--CREATE TABLE tmp_addresses_invalid
--AS
INSERT INTO tmp_addresses_invalid
SELECT a.*
  FROM tmp_addresses a
 WHERE TRIM(a.adr_country) = 'NOR' 
   AND 0                   = (SELECT COUNT(1)
                                FROM zip_decode z
                               WHERE a.adr_zip         = z.zip_code
                                 AND UPPER(a.adr_city) = z.city)
;

COMMIT WORK
;

SELECT COUNT(1) AS "ADR_COUNT"
  FROM tmp_addresses_invalid
;

SELECT a.adr_zip, a.adr_city, COUNT(1) AS "ADR_COUNT"
  FROM tmp_addresses_invalid a
GROUP BY a.adr_zip, a.adr_city
ORDER BY 3 DESC
;

