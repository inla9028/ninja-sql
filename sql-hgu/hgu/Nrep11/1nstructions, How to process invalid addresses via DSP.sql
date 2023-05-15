/*
** How to proceed with handling the update/correction of addresses in Fokus
*/

/*
** NINJA DB - NINJA DB - NINJA DB - NINJA DB - NINJA DB - NINJA DB - NINJA DB
*/

/*
** Stop the Ninja Batch DSP Extract job
*/
update ninja_jobs a
   set a.job_status  = 'STOPPING'
 where a.machine_id  = 'NINJAP2_DEMON'
   and a.exec_method = 'batchDspExtract'
   and a.job_status IN ( 'SLEEPING', 'RUNNING' )
;

select a.machine_id, a.job_id, a.job_status
     , LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME"
     , TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW"
     , TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME"
     , LTRIM(TO_CHAR(TRUNC(SYSDATE - a.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - a.status_time), ':HH24:MI:SS') AS "RUNTIME",
       a.exec_method, a.job_desc
  from ninja_jobs a
 where a.machine_id  = 'NINJAP2_DEMON'
   and a.exec_method IN ( 'batchDspExtract', 'batchDspUpdate' )
;

/*
** Make sure we update all addresses.
*/
update system_defaults a
   set a.value = 'Y'
 where a.key  in ( 'DSP_UPDATE_ADDRESS_BILLING', 'DSP_UPDATE_ADDRESS_USER' )
   and a.value = 'N'
;

/*
** Nrep11 DB - Nrep11 DB - Nrep11 DB - Nrep11 DB - Nrep11 DB - Nrep11 DB
*/

-- Run the scripts...:
--   Nrep11/Refresh ZIP_DECODE from Fokus.sql
--   Nrep11/Insert names and addresses into table.sql
--   Nrep11/Insert names of invalid addresses into table.sql

/*
** Ninja DB - NINJA DB - NINJA DB - NINJA DB - NINJA DB - NINJA DB - NINJA DB
*/

-- Run the scripts...:
-- Nrep11/Insert invalid addresses into DSP_REQUEST table.sql

/*
** Monitor the process.
*/
SELECT *
  FROM (
    SELECT TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '1. Extracted' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_request rq
     WHERE rq.request_user_id = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
    GROUP BY TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '2. Pending' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PENDING'
       AND rs.record_creation_date > TO_DATE('2019-10-02 09:00', 'YYYY-MM-DD HH24:MI')
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '3. Waiting' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'WAITING'
       AND rs.record_creation_date > TO_DATE('2019-10-02 09:00', 'YYYY-MM-DD HH24:MI')
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '4. Updated' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_SUCCESS'
       AND rs.record_creation_date > TO_DATE('2019-10-02 09:00', 'YYYY-MM-DD HH24:MI')
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '5. Failed' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_ERROR'
       AND rs.record_creation_date > TO_DATE('2019-10-02 09:00', 'YYYY-MM-DD HH24:MI')
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
)
ORDER BY 1, 2
;

/*
** Before we start the DSP extract job again, make sure we only update legal addresses.
*/
update system_defaults a
   set a.value = 'N'
 where a.key  in ( 'DSP_UPDATE_ADDRESS_BILLING', 'DSP_UPDATE_ADDRESS_USER' )
   and a.value = 'Y'
;


/*
** Start the DSP Extract job...
*/
update ninja_jobs a
   set a.job_status  = 'STARTING'
 where a.machine_id  = 'NINJAP2_DEMON'
   and a.exec_method = 'batchDspExtract'
   and a.job_status  = 'STOPPED'
;

/*
** Monitor DSP job(s).
*/
select a.machine_id, a.job_id, a.job_status
     , LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME"
     , TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW"
     , TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME"
     , LTRIM(TO_CHAR(TRUNC(SYSDATE - a.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - a.status_time), ':HH24:MI:SS') AS "RUNTIME",
       a.exec_method, a.job_desc
  from ninja_jobs a
 where a.machine_id   = 'NINJAP2_DEMON'
   and a.exec_method IN ( 'batchDspExtract', 'batchDspUpdate' )
;


