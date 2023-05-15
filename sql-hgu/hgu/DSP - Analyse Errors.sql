--== List today's errors
SELECT rq.request_id, rq.customer_id,rq.adr_first_name, rq.adr_last_name
     , rq.adr_birth_date, rq.adr_zip, rq.process_time AS "EXTRACT_TIME"
     , rs.process_time AS "UPDATE_TIME", rs.process_status, rs.status_desc
  FROM dsp_request rq, dsp_response rs
 WHERE rs.request_id     = rq.request_id
   AND rq.customer_id    = 623115904
ORDER BY 1
;

--== List the comparison between extracted, and successful/failed updates per day
SELECT *
  FROM (
    SELECT TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD') AS "DATE"
         , '1. Extracted' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_request rq
    GROUP BY TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD')
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD') AS "DATE"
         , '2. Updated' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_SUCCESS'
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD')
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD') AS "DATE"
         , '3. Failed' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_ERROR'
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD')
)
ORDER BY 1, 2
;

--== List an overview of the errors, whenever...
SELECT *
  FROM (
    SELECT '1. Extracted' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_request rq
    UNION
    SELECT '2. Updated' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_SUCCESS'
    UNION
    SELECT '3. Failed' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_ERROR'
)
ORDER BY 1, 2
;

--== Differentiate the errors...
SELECT "STATUS_DESC", COUNT(1) AS "COUNT"
  FROM
(
    SELECT RTRIM(SUBSTR(rs.status_desc, 0, INSTR(rs.status_desc || ': ', ': ') - 1)) AS "STATUS_DESC"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_ERROR'
--       AND rs.process_time   > TRUNC(SYSDATE - 5)
)
GROUP BY "STATUS_DESC"
ORDER BY 1, 2
;

--== List a random selection of errors.
SELECT * FROM
(
    SELECT rq.request_id, rq.customer_id,rq.adr_first_name, rq.adr_last_name
         , rq.adr_birth_date, rq.adr_zip, rq.process_time
         , rs.process_status, rs.status_desc
      FROM dsp_request rq, dsp_response rs
     WHERE rs.process_status = 'PRSD_ERROR'
       AND rs.request_id     = rq.request_id
       AND rs.status_desc    = 'IPL_NATIONALREGISTRY_PERSON_NOT_FOUND'
    ORDER BY dbms_random.value
)
WHERE ROWNUM < 21
ORDER BY 1
;

--== List the number of _unique_ BAN's we've processed, split on status.
SELECT "PROCESS_STATUS", COUNT(1) AS "COUNT"
  FROM (
    SELECT UNIQUE rq.customer_id, rs.process_status
      FROM dsp_request rq, dsp_response rs
     WHERE rs.request_id     = rq.request_id
    GROUP BY rq.customer_id, rs.process_status
)
GROUP BY "PROCESS_STATUS"
ORDER BY "PROCESS_STATUS"
;

