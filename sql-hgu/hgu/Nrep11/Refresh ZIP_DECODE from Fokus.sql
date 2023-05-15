-- First handle the backup/previous table.
DELETE
  FROM zip_decode_prev
;

--CREATE TABLE zip_decode_prev
--AS
INSERT INTO zip_decode_prev
SELECT a.zip_code, a.city, a.sys_creation_date
  from zip_decode a
ORDER BY a.zip_code
;

COMMIT WORK
;

-- Now handle the main table...

DELETE
  FROM zip_decode
;

/*
--CREATE TABLE zip_decode
--AS
INSERT INTO zip_decode
SELECT a.zip_code, a.city, a.sys_creation_date
  from zip_decode@p01ol1 a
ORDER BY a.zip_code
;
*/

INSERT INTO zip_decode
SELECT a.zip_code, a.city, a.sys_creation_date
  FROM address_validation@p01ol1 a
GROUP BY a.zip_code, a.city, a.sys_creation_date
ORDER BY a.zip_code
;

COMMIT WORK
;

SELECT *
  FROM (SELECT 'ZIP_DECODE'      AS "NAME", COUNT(1) AS "COUNT" FROM zip_decode      a
  UNION SELECT 'ZIP_DECODE_PREV' AS "NAME", COUNT(1) AS "COUNT" FROM zip_decode_prev a)
;