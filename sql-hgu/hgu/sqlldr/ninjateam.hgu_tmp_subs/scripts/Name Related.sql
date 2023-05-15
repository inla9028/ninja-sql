SELECT A.*
  FROM hgu_tmp_subs A
-- WHERE A.param7 LIKE 'B%'
-- WHERE UPPER(a.param1) = a.param5
-- WHERE A.param4 IS NULL
--   AND A.param3 IS NOT NULL
--   AND A.param3 != 'C'
-- WHERE A.subscriber_no = 'GSM04792088206'
-- WHERE A.param9 IS NULL
ORDER BY 1,2
;

UPDATE hgu_tmp_subs A
   SET A.param7 = NULL
;

--DELETE
--  FROM hgu_tmp_subs A
--;

SELECT A.param4 as "NAME_FORMAT", a.param7 AS "ACCOUNT_TYPE", count(1) AS "COUNT"
  FROM hgu_tmp_subs A
GROUP BY A.param4, A.param7
ORDER BY 1,2
;

SELECT A.param3 as "SUB_STATUS", count(1) AS "COUNT"
  FROM hgu_tmp_subs A
GROUP BY A.param3
ORDER BY 1
;

SELECT A.param4 as "NAME_FORMAT", a.param7 AS "ACCOUNT_TYPE", count(1) AS "COUNT"
  FROM hgu_tmp_subs A
GROUP BY A.param4, A.param7
ORDER BY 1,2
;

SELECT A.param9 as "STATE", count(1) AS "COUNT"
  FROM hgu_tmp_subs A
GROUP BY A.param9
ORDER BY 1
;

select * from (
SELECT A.subscriber_no, count(1) AS "COUNT"
  FROM hgu_tmp_subs A
GROUP BY A.subscriber_no
ORDER BY 1
) where "COUNT" > 1
;


SELECT A.param3 as "SUB_STATUS", A.param4 as "NAME_FORMAT", DECODE(a.param5, NULL, NULL, 'OK') AS "FIRST_NAME", count(1) AS "COUNT"
  FROM hgu_tmp_subs A
 WHERE A.param3 IN ('A', 'R', 'S')
GROUP BY A.param3, A.param4,decode(A.param5, NULL, NULL, 'OK')
ORDER BY 1,2,3
;

SELECT A.param3 AS "SUB_STATUS", A.param4 AS "NAME_FORMAT"
     , decode(A.param5, NULL, NULL, 'OK') AS "FIRST_NAME"
     , decode(upper(A.param1), A.param5, 'Equal', 'Different') AS fname_status
     , a.param9 AS "STATE"
     , count(1) AS "COUNT"
  FROM hgu_tmp_subs A
 WHERE A.param3 IN ('A', 'R', 'S')
GROUP BY A.param3, A.param4, decode(A.param5, NULL, NULL, 'OK'), DECODE(UPPER(a.param1), a.param5, 'Equal', 'Different'), a.param9
ORDER BY 1,2,3,4
;

SELECT A.*
  FROM ninjadata.batch_name_update A
 WHERE A.requestor_id = 'HGU 2020-01-07.1'
   AND A.process_status = 'PRSD_ERROR'
;

SELECT A.requestor_id, A.process_status, COUNT(1) AS "COUNT"
  FROM ninjadata.batch_name_update A
 WHERE A.requestor_id = 'HGU 2020-01-07.1'
GROUP BY A.requestor_id, A.process_status
order by A.requestor_id, A.process_status
;

SELECT A.*
  FROM zip_decode@fokus A
 WHERE A.city = 'OSLO'
order by 1
;

UPDATE hgu_tmp_subs A
   SET A.param9 = 'HGU 2020-01-07.1'
 WHERE A.param3 IN ('A', 'R', 'S')
   AND A.param5 IS NULL
   AND A.param9 IS NULL
;

UPDATE hgu_tmp_subs A
   SET A.param9 = 'Duplicate order in OM'
 WHERE a.param9 = 'Duplicate'
;


INSERT INTO ninjadata.batch_name_update (subscriber_no, link_type, name_type, first_name,REQUESTOR_ID)
SELECT A.subscriber_no, 'U', A.param4, upper(A.param1), A.param9
  FROM hgu_tmp_subs A
 WHERE a.param9 = 'HGU 2020-01-07.1'
ORDER BY 1
;

SELECT A.*
  FROM hgu_tmp_subs A
 where A.param3 IN ('A', 'R', 'S')
   AND A.param4 IS NOT NULL
   AND A.param5 IS NOT NULL
   AND UPPER(a.param1) != a.param5
ORDER BY 1
;

SELECT b.*
  FROM hgu_tmp_subs b
 where b.subscriber_no IN (
select subscriber_no from (
SELECT A.subscriber_no, count(1) as "COUNT"
  from hgu_tmp_subs A
 WHERE A.param3 IN ('A', 'R', 'S')
   AND A.param4 IS NOT NULL
   AND A.param5 IS NULL
   and a.param9 != 'DUPLICATE'
GROUP BY A.subscriber_no
) WHERE "COUNT" > 1)
order by 1
;

UPDATE hgu_tmp_subs b
   set b.param9 = 'DUPLICATE'
 where b.subscriber_no IN (
select subscriber_no from (
SELECT A.subscriber_no, count(1) as "COUNT"
  from hgu_tmp_subs A
 WHERE A.param3 IN ('A', 'R', 'S')
   AND A.param4 IS NOT NULL
   AND A.param5 IS NULL
GROUP BY A.subscriber_no
) WHERE "COUNT" > 1)
;