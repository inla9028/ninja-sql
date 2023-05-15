--== For 12 hours/today, split on Extracted, Successfully updated and Failed updates.
SELECT *
  FROM (
    SELECT TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '1. Extracted' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_request rq
     WHERE rq.record_creation_date > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
    GROUP BY TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '2. Pending' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PENDING'
       AND rs.record_creation_date > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '3. Waiting' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'WAITING'
       AND rs.record_creation_date > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '4. Updated' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_SUCCESS'
       AND rs.record_creation_date > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '5. Failed' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_ERROR'
       AND rs.record_creation_date > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
)
ORDER BY 1, 2
;

--== For the last 12 hours/day, split on Request and Response.
SELECT *
  FROM (
    SELECT 'DSP_REQUEST' AS "TABLE_NAME"
         , TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "RECORD_CREATION_DATE"
         , COUNT(*) AS "COUNT"
      FROM dsp_request rq
     WHERE rq.record_creation_date > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
    GROUP BY TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT 'DSP_RESPONSE' AS "TABLE_NAME"
         , TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "RECORD_CREATION_DATE"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.record_creation_date > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
)
ORDER BY 2, 1
;

--== For the current week...
SELECT *
  FROM (
    SELECT TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD') AS "DATE"
         , '1. Extracted' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_request rq
     WHERE rq.record_creation_date > TRUNC(SYSDATE - 7) -- TRUNC(SYSDATE, 'DAY')
    GROUP BY TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD')
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD') AS "DATE"
         , '2. Updated' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_SUCCESS'
       AND rs.record_creation_date > TRUNC(SYSDATE - 7) -- TRUNC(SYSDATE, 'DAY')
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD')
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD') AS "DATE"
         , '3. Failed' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_ERROR'
       AND rs.record_creation_date> TRUNC(SYSDATE - 7) -- TRUNC(SYSDATE, 'DAY')
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD')
)
ORDER BY 1, 2
;

--== For the current week, display the number of processed records per hour...
SELECT *
  FROM (
    SELECT TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD HH24:') || '00-59' AS "DATE"
         , '1. Extracted' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_request rq
     WHERE rq.record_creation_date > TRUNC(SYSDATE - 7) -- TRUNC(SYSDATE, 'DAY')
    GROUP BY TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD HH24:') || '00-59'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24:') || '00-59' AS "DATE"
         , '2. Updated' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_SUCCESS'
       AND rs.record_creation_date > TRUNC(SYSDATE - 7) -- TRUNC(SYSDATE, 'DAY')
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24:') || '00-59'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24:') || '00-59' AS "DATE"
         , '3. Failed' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_ERROR'
       AND rs.record_creation_date> TRUNC(SYSDATE - 7) -- TRUNC(SYSDATE, 'DAY')
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24:') || '00-59'
)
ORDER BY 1, 2
;

--== Forever...
SELECT *
  FROM (
    SELECT 'DSP_REQUEST' AS "TABLE_NAME"
         , TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "RECORD_CREATION_DATE"
         , COUNT(*) AS "COUNT"
      FROM dsp_request rq
    GROUP BY TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT 'DSP_RESPONSE' AS "TABLE_NAME"
         , TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "RECORD_CREATION_DATE"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
)
ORDER BY 2, 1
;

--== List the remaining numbers of un-registered customers.
SELECT COUNT(*) AS "COUNT"
  FROM dsp_info di
 WHERE NOT EXISTS (
   SELECT ''
     FROM dsp_request rq
    WHERE rq.customer_id = di.ban
)
;

--== List the 10 last extracted users...
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW"
     , rq.*
  FROM dsp_request rq
 WHERE rq.request_id > (SELECT MAX(req.request_id) - 10
                          FROM dsp_request req)
ORDER BY 1
;

--== List the 10 last updated users...
SELECT * FROM (
    SELECT * FROM (
        SELECT rs.*
          FROM dsp_response rs
         WHERE rs.request_id > (SELECT MAX(res.request_id) - 100
                                  FROM dsp_response res)
           AND rs.process_status = 'PRSD_SUCCESS'
    )
    ORDER BY 1 DESC
)
 WHERE ROWNUM < 11
ORDER BY 1 ASC
;

--== List the 10 last failed updates
SELECT * FROM (
    SELECT * FROM (
        SELECT rs.*
          FROM dsp_response rs
         WHERE rs.request_id > (SELECT MAX(res.request_id) - 80000
                                  FROM dsp_response res)
           AND rs.process_status = 'PRSD_ERROR'
    )
    ORDER BY 1 DESC
)
 WHERE ROWNUM < 11
ORDER BY 1 ASC
;

--== List the requests for the 20 last failed updates
SELECT rq.request_id, rq.customer_id, rq.adr_first_name, rq.adr_last_name,
       rq.adr_birth_date, rq.adr_zip, rq.record_creation_date,
       rq.status_desc, rs.process_time, rs.process_status, rs.status_desc
  FROM dsp_request rq, dsp_response rs
 WHERE rq.request_id = rs.request_id
   AND rs.request_id IN (
        SELECT * FROM (
            SELECT request_id FROM (
                SELECT rs2.request_id
                  FROM dsp_response rs2
                 WHERE rs2.request_id > (SELECT MAX(rs3.request_id) - 40000
                                          FROM dsp_response rs3)
                   AND rs2.process_status = 'PRSD_ERROR'
            )
            WHERE ROWNUM < 21
            ORDER BY 1 DESC
        )
    )
ORDER BY 1 ASC
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

--== List the number of extracted customers for the last two weeks,
--== including the current day.
SELECT *
  FROM (
    SELECT TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD') AS "DATE"
         , COUNT(*) AS "COUNT"
      FROM dsp_request rq
     WHERE rq.record_creation_date > TRUNC(SYSDATE -14)
    GROUP BY TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD')
)
ORDER BY 1
;

--== Get the next 60 from the view towards the snapshot
SELECT di.ban, di.first_name, di.last_business_name, di.birth_date, di.adr_zip
  FROM dsp_info di
 WHERE ROWNUM < 61
;

-- List current queue...
SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "RECORD_CREATION_DATE"
     , rs.process_status, COUNT(1) AS "COUNT"
  FROM dsp_response rs
 WHERE rs.record_creation_date > TRUNC(SYSDATE)
GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx', rs.process_status
ORDER BY 1, 2
;

SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD') AS "RECORD_CREATION_DATE"
     , rs.process_status, COUNT(1) AS "COUNT"
  FROM dsp_response rs
 WHERE rs.record_creation_date > TRUNC(SYSDATE)
GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD'), rs.process_status
ORDER BY 1, 2
;

SELECT rq.request_user_id, TO_CHAR(NVL(rq.process_time, rq.record_creation_date), 'YYYY-MM-DD') AS "REQ_OR_PROCESS_TIME", rq.process_status, COUNT(1) AS "COUNT"
  FROM dsp_request rq
 WHERE rq.request_user_id IN (  'HGU 2018-06-18',  'HGU 2018-06-21' )
GROUP BY rq.request_user_id, TO_CHAR(NVL(rq.process_time, rq.record_creation_date), 'YYYY-MM-DD'), rq.process_status
ORDER BY 1,2,3
;

SELECT rq.request_user_id, rs.process_status, COUNT(1) AS "COUNT"
  FROM dsp_request rq, dsp_response rs
 WHERE rq.request_user_id IN (  'HGU 2018-06-18',  'HGU 2018-06-21' )
   AND rq.request_id = rs.request_id
GROUP BY rq.request_user_id, rs.process_status
ORDER BY 1,2
;

