select a.*
  from ninja_jobs a
 where a.machine_id = 'NINJAAT2_SH1'
   and a.job_id between 110 and 119
;

-- Stop
update ninja_jobs a
   set a.job_status   = 'STOPPING'
 where a.machine_id   = 'NINJAAT2_SH1'
   and a.job_id between 110 and 119
   and a.job_status  in ('RUNNING', 'SLEEPING')
;

-- Start
update ninja_jobs a
   set a.job_status   = 'STARTING'
 where a.machine_id   = 'NINJAAT2_SH1'
   and a.job_id between 110 and 119
   and a.job_status  in ('STOPPED')
;

-- Jobs...
SELECT a.request_id, a.action_code, a.soc, DECODE(a.stream, '1', '1', '2-N') AS "STREAM", a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.422) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.422) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_transactions a
 WHERE a.request_id IN ( 'HGU 2019-11-09' )
--   AND a.action_code   = 'ADD'
GROUP BY a.request_id, a.action_code, a.soc, DECODE(a.stream, '1', '1', '2-N'),  a.process_status
ORDER BY a.request_id, a.action_code, a.soc, "STREAM", a.process_status
;