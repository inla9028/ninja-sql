--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==select amount of WAITING records from service_transactions by priority
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
select process_status, priority, count(*)
from ninjadata.service_transactions
where enter_time>TRUNC(SYSDATE-10)
and process_status='WAITING'
--AND (status_desc LIKE '%No Jolt connections available%' or status_desc like '%Tuxedo system exception occurred during the execution of the Tuxedo service: gnGtLgclDt00%') 
group by process_status, priority


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Remove duplicates by changing the status of all but the last request --==--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT b.*
      FROM ninjadata.service_transactions a, ninjadata.service_transactions b
      WHERE ((a.process_status = b.process_status AND b.process_status = 'WAITING') OR
            (b.process_status = 'WAITING' and a.process_status = 'TRANSFER' and a.status_desc = 'TRANSFER1 2010.11.03'))
        AND a.subscriber_no  = b.subscriber_no
        AND a.soc            = b.soc
        AND a.action_code    = b.action_code
        AND a.trans_number   < b.trans_number
        AND a.enter_time     < b.enter_time
        order by a.enter_time

UPDATE ninjadata.service_transactions x
  SET x.process_status = 'TRANSFER', x.status_desc = 'DUPLICATE 2010.11.03', x.process_time = SYSDATE
  WHERE x.process_status = 'WAITING'
    AND x.trans_number IN (
    SELECT a.trans_number
      FROM ninjadata.service_transactions a, ninjadata.service_transactions b
      WHERE a.process_status = b.process_status 
        AND b.process_status = 'WAITING'
        AND a.subscriber_no  = b.subscriber_no
        AND a.soc            = b.soc
        AND a.action_code    = b.action_code
        AND a.trans_number   < b.trans_number
        AND a.enter_time     < b.enter_time
)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Set the currently waiting to a temporary status --==--==--==--==--==--==--=
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.service_transactions x
  SET x.process_status = 'TRANSFER', 
      x.status_desc    = 'TRANSFER1 2010.11.03', 
	  x.process_time   = SYSDATE
  WHERE x.process_status = 'WAITING'
 and priority > 3

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==Move records from service_transactions to mw_tmp_trans
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==  
  SELECT a.subscriber_no, a.soc, a.action, a.feature, a.parameter,
       a.parm_value, a.request_id, a.memo_text, a.feature2,
       a.parameter2, a.parm_value2, a.feature3, a.parameter3,
       a.parm_value3, a.feature4, a.parameter4, a.parm_value4
  FROM ninjateam.mw_tmp_trans a
  
  select count(*) FROM ninjateam.mw_tmp_trans a


INSERT INTO ninjateam.mw_tmp_trans
  SELECT a.subscriber_no, a.soc, a.action_code, NULL, NULL, NULL, 'TRANSFER1 2010.11.03',
         NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM ninjadata.service_transactions a
    WHERE a.process_status = 'TRANSFER'
      and a.status_desc    = 'TRANSFER1 2010.11.03'
      --and a.enter_time > sysdate-.1
    order by a.trans_number

-- run MW_PROCS.load_master_transactions procedure on ninjateam schema to load transactions from mw_tmp_trans to master_transactions

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Spread the records in master_transactions on multiple streams ==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.stream = DECODE(MOD(SUBSTR(a.subscriber_no, 4), 10) + 1, null, 1, MOD(SUBSTR(a.subscriber_no, 4), 10) + 1)
--    , a.request_time = TO_DATE('2008-03-13 01:45', 'YYYY-MM-DD HH24:MI')
  WHERE a.request_id IN ('TRANSFER1 2010.11.03')
    AND a.process_status = 'WAITING'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the remaining records, per stream... ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT"
       --,TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.264) / 3600), '9999999'))) || ' hours ' ||
       --TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.264) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('TRANSFER1 2010.11.03')
    AND a.process_status = 'WAITING'
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Set streams to STARTING...                   ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  
  UPDATE ninjaconfig.ninja_jobs a
  SET a.job_status = 'STARTING'
  WHERE a.machine_id = 'NINJAP2_DEMON'
    AND a.exec_method='masterManipulator'
    AND a.job_status NOT IN ('RUNNING', 'STOPPING', 'SLEEPING')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display total of remaining records ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==    
  select process_status, count(*)
  FROM ninjadata.master_transactions a
  where a.request_id in ('TRANSFER1 01.04.2009')
  group by process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display errors                               ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==  
  
  SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code, a.new_soc,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.request_id, a.memo_text, a.waive_act_fee, a.stream
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('TRANSFER1 03.12.2008')
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR'
    order by a.status_desc
 
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process errors                            ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==  
   update ninjadata.master_transactions a
    set process_status = 'WAITING',status_desc=null
    where  a.request_id     IN ('TRANSFER1 03.12.2008')
    and a.process_status='PRSD_ERROR'
    and status_desc like '%Tuxedo service did not terminate successfully.%'
    
    
    update ninjadata.master_transactions a
    set stream = 3
    where a.request_id     IN ('TRANSFER1 03.12.2008')
    AND a.process_status = 'WAITING'
    
    select count(*) from service_transactions where status_desc= 'TRANSFER1 2008.12.02'
    
    
