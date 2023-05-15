--DROP TABLE hgu_tpid_extract PURGE
--;

--CREATE TABLE hgu_tpid_extract (
--  tpid            VARCHAR2(60 CHAR),
--  email           VARCHAR2(150 CHAR),
--  phone           VARCHAR2(20 CHAR),
--  account_id      NUMBER(9,0)
--)
--;

DELETE FROM hgu_tpid_extract
;

--CREATE table hgu_tpid_extract
--AS
INSERT INTO hgu_tpid_extract
SELECT /*+ parallel(nd , 6 )*/
       nd.tpid                                                AS "TPID"
     , ad.adr_email                                           AS "EMAIL"
     , decode(c.customer_telno, '0', NULL, c.customer_telno)  AS "PHONE"
     , anl.customer_id                                        AS "ACCOUNT_ID"
  FROM name_data nd, address_name_link anl, address_data ad, customer c
 WHERE nd.tpid IS NOT NULL
   AND LENGTH(nd.tpid) = 36
   AND nd.name_id      = anl.name_id
   AND SYSDATE BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
   AND anl.address_id  = ad.address_id
   AND anl.customer_id = c.customer_id
--   AND ROWNUM   < 10001
;

COMMIT WORK;

SELECT count(1) AS "TABLE_ROW_COUNT"
  FROM hgu_tpid_extract A
;

SELECT b.email, b.phone, count(1) AS "COUNT"
  FROM (SELECT decode(A.email, NULL, 'No', 'Yes') AS "EMAIL"
             , decode(A.phone, NULL, 'No', 'Yes') AS "PHONE"
          FROM hgu_tpid_extract A) b
GROUP BY b.email, b.phone
ORDER BY b.email, b.phone
;

SELECT count(1) as "COUNT"
  FROM (
  SELECT UNIQUE A.tpid, A.email, A.phone, A.account_id
    FROM hgu_tpid_extract A
   WHERE A.email IS NOT NULL
      OR A.phone IS NOT NULL
)
;

-- Finally, the complete extract.
SELECT UNIQUE A.tpid, A.email, A.phone, A.account_id
  FROM hgu_tpid_extract A
 WHERE A.email IS NOT NULL
    OR A.phone IS NOT NULL
;