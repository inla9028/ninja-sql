SELECT a.*, z.zip_code AS "CORRECT_ZIP", z.city AS "CORRECT_CITY"
  FROM tmp_addresses_invalid a, zip_decode z
 WHERE TRIM(a.adr_zip) = z.zip_code(+)
ORDER BY TRIM(a.adr_zip), a.adr_city
;

SELECT b.adr_zip, b.adr_city, b.correct_zip, b.correct_city, COUNT(1) AS "COUNT"
  FROM (
  SELECT a.adr_zip, a.adr_city, z.zip_code AS "CORRECT_ZIP", z.city AS "CORRECT_CITY"
    FROM tmp_addresses_invalid a, zip_decode z
   WHERE TRIM(a.adr_zip) = z.zip_code(+)) b
 WHERE b.correct_zip IS NULL
GROUP BY b.adr_zip, b.adr_city, b.correct_zip, b.correct_city
ORDER BY "COUNT" DESC
;

SELECT a.*, z.zip_code AS "CORRECT_ZIP", z.city AS "CORRECT_CITY"
  FROM tmp_addresses_invalid a, zip_decode z
 WHERE LENGTH(TRIM(a.adr_zip)) = 4
   AND a.adr_zip              != '0000'
   AND TRIM(a.adr_zip)         = z.zip_code(+)
ORDER BY TRIM(a.adr_zip), a.adr_city, a.ban, a.link_type
;

SELECT TRIM(a.adr_zip) AS "ADR_ZIP", COUNT(1) AS "COUNT"
  FROM tmp_addresses_invalid a
GROUP BY TRIM(a.adr_zip)
ORDER BY 1
;

SELECT TRIM(a.adr_city) AS "ADR_CITY", COUNT(1) AS "COUNT"
  FROM tmp_addresses_invalid a
GROUP BY TRIM(a.adr_city)
ORDER BY 2 DESC
;

SELECT a.ban, a.subscriber_no, a.link_type, a.address_id
     , a.adr_country, a.adr_zip, a.adr_city, a.sys_creation_date
     , z.zip_code AS "CORRECT_ZIP", z.city AS "CORRECT_CITY"
  FROM tmp_addresses_invalid a, zip_decode z
 WHERE TRIM(a.adr_zip) = z.zip_code(+)
ORDER BY a.adr_zip
;

SELECT a.adr_zip, a.adr_city
     , z.zip_code AS "CORRECT_ZIP", z.city AS "CORRECT_CITY"
     , COUNT(1) AS "COUNT"
  FROM tmp_addresses_invalid a, zip_decode z
 WHERE TRIM(a.adr_zip) = z.zip_code(+)
GROUP BY a.adr_zip, a.adr_city, z.zip_code, z.city
ORDER BY "COUNT" DESC
;
