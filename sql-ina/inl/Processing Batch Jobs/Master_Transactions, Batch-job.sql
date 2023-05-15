--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all (or failed) records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code, a.new_soc,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.request_id, a.memo_text, a.waive_act_fee, a.stream
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('STLI15-12.04.2013')
 -- and request_time > sysdate-1
--a.enter_time     > sysdate -3
    and a.status_desc not like '%SOC is already on subscription!%'
  --  and a.status_desc not like '%is Not Active or Reserved - Current Status is%'
    --and a.status_desc like '%has been changed since last retrieved%'
    --and a.status_desc not like '%DuplicateFeaturesException: Found%'
    --and a.status_desc not like '%Found 1 illegal soc combination%'
    --and a.status_desc not like '%SOC is not available for add to subscription!%'
    and a.process_status = 'PRSD_ERROR' 
    --and rownum < 50
    --and soc='FISDNGT'
    --and a.status_desc    LIKE '%Tuxedo service did not terminate successfully.%'
    --and a.status_desc    LIKE '%Found 1 duplicate feature%'
    order by --a.request_time desc
    a.status_desc
    

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per stream...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.264) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.264) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id like ('STLI15-12.04.2013')
   AND a.enter_time > TRUNC(SYSDATE-1)
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status
  
  --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.264) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.264) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('STLI15-12.04.2013')
   AND a.enter_time > TRUNC(SYSDATE-1)
  GROUP BY a.process_status
  ORDER BY a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the remaining records, per stream... ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.264) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.264) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('HFA 28.01.2009')
    AND a.process_status = 'WAITING'
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per stream, action and operation... -==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.action_code, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.264) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.264) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('HGU 25.07.2008')
--    AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.process_status, a.action_code, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.action_code, a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per operation ... =--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action_code, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.264) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.264) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('HGU 25.07.2008')
--    AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.action_code, a.process_status
  ORDER BY a.action_code, a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with complete status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.status_desc
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('STLI 08.12.2010')
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     like  ('HFA 09.03.2009')
    --AND a.enter_time     > TRUNC(SYSDATE-2)
    AND a.process_status = 'PRSD_ERROR'
   --AND a.status_desc NOT LIKE '%SOC is already on subscription%'
   --and a.status_desc not like '% SOC is not available for add to subscription!%'
   --and a.status_desc not like '% is Non Active - Current Status%'
   --and a.status_desc not like '%: Found 2 duplicate features:%'
   --and a.status_desc not like '%: Found 3 duplicate features:%'
   --and a.status_desc not like '%[VMEPOST%'
  ORDER BY a.status_desc
--  ORDER BY SUBSTR("STATUS_DESC", 0, 40), a.subscriber_no

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.action_code, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('HFA 28.01.2009')
      AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.action_code

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with action code, soc & trimmed status
--== description.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.action_code, a.soc, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('HFA 27.12.2008')
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR'
  --ORDER BY a.subscriber_no, a.action_code, a.soc
  order by a.status_desc

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Pause all waiting requests...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'IN_PROGRESS'
  WHERE a.request_id     IN ('HGU 25.07.2008')
    AND a.process_status = 'WAITING'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Resume all paused records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
--      , a.action_code = 'ADD'
  WHERE a.request_id     IN ('HGU 25.07.2008')
    AND a.process_status = 'IN_PROGRESS'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Set the execution time for these operations (that hasn't been run yet).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.request_time = TO_DATE('2008-06-17 01:30', 'YYYY-MM-DD HH24:MI')
  WHERE a.request_id         IN ('HGU 25.07.2008')
    AND a.process_status NOT IN ('PRSD_ERROR', 'PRSD_SUCCESS')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-run records that failed as the soc already exists (thus can't be added).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL,
      a.action_code = 'MODIFY'
  WHERE a.request_id     IN ('HGU 25.07.2008')
    AND a.process_status = 'PRSD_ERROR'
    AND a.action_code    = 'ADD'
    AND a.status_desc LIKE '%SocException: SOC is already on subscription%'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-run records that failed as the soc didn't exists (thus can't be modified).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL,
      a.action_code = 'ADD'
  WHERE a.request_id     IN ('HGU 25.07.2008')
    AND a.process_status = 'PRSD_ERROR'
    AND a.action_code    = 'MODIFY'
    AND a.status_desc LIKE '%SocException: SOC does not exist on subscription%'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-run all failed records =--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
, a.stream = '1'
  WHERE a.request_id     IN ('STLI15-12.04.2013')
    AND a.process_status = 'PRSD_ERROR'
    AND (a.status_desc    LIKE '%No Jolt connections available%'
      OR a.status_desc    LIKE '%Could not retrieve fokus dates%'
      OR a.status_desc    LIKE '%Records have been updated since last retrieve%'
      OR a.status_desc    LIKE '%Please try accessing account again later%'
      OR a.status_desc    LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service:%'
      --OR a.status_desc    LIKE '%Tuxedo service did not terminate successfully.%'
      OR a.status_desc    LIKE '%RunTime Error : java.util.ConcurrentModificationException%'
    )

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT to_char(a.process_time, 'YYYY-MM-DD HH24:MI') AS time, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id   IN ('HGU 25.07.2008')
    AND a.process_time IS NOT NULL
  GROUP BY to_char(a.process_time, 'YYYY-MM-DD HH24:MI')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time of the first- and last processed records. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT MIN(a.process_time) AS "FIRST_PROCESSED", MAX(a.process_time) AS "LAST_PROCESSED"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('HGU 25.07.2008')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute, for the last
--== 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM ninjadata.master_transactions a
      WHERE a.request_id    IN ('HGU 25.07.2008')
        AND a.process_status != 'WAITING'
        AND a.process_time    > SYSDATE - (15 / 1440)
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Spread the records (marked as 'IN_PROGRESS') on multiple streams ==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.stream = DECODE(MOD(SUBSTR(a.subscriber_no, 4), 10) + 1, null, 1, MOD(SUBSTR(a.subscriber_no, 4), 10) + 1)
--    , a.request_time = TO_DATE('2008-03-13 01:45', 'YYYY-MM-DD HH24:MI')
  WHERE a.request_id IN ('STLI15')
    AND a.process_status = 'WAITING'


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== In case one already has spread the load on multiple streams, but forgot -==
--== to start the processes, one could re-spread them again, and give it a   -==
--== second try..                                                            -==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.stream = MOD(SUBSTR(a.subscriber_no, 8, 3), 10) + 1
  WHERE a.request_id IN ('BEI')
    AND a.process_status = 'WAITING'
    AND a.stream         = '10'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== The last 10-20 changes might be difficult due to constant BAN-locks.  =--==
--== Stop the additional master manipulators and set the stream to '1' for =--==
--== the remaining records...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.stream = '9'
  WHERE a.request_id IN ('HFA 28.01.2009')
    AND a.process_status = 'WAITING'
    AND a.stream        ='3'

select process_status, count(*)
from ninjadata.master_transactions a
where a.request_id like 'TOAV PRJ4441'
and a.request_time > sysdate - 1 and a.request_time < sysdate
group by process_status

select count(*) 
from master_transactions a
where a.process_time >= TO_DATE('2008-12-14 09:00', 'YYYY-MM-DD HH24:MI')
and a.process_time <= TO_DATE('2008-12-15 09:00', 'YYYY-MM-DD HH24:MI')
and a.request_id='HFA 13.12.2008'

update master_transactions a
set a.process_status='WAITING', a.status_desc=null
where a.subscriber_no = 'GSM04740641852'
and a.process_status='PRSD_ERROR'
and a.request_time = (select max(request_time) from master_transactions b
                    where b.subscriber_no=a.subscriber_no
                    and b.soc=a.soc
                    and b.action_code=a.action_code
                    and b.process_status='PRSD_ERROR')
                    
select * from master_transactions a
where a.subscriber_no = 'GSM04746443564'
and a.process_time > sysdate -1
and a.process_status='PRSD_ERROR'


select process_status, count(*) from master_transactions
where request_id='TB-TEAM 01.04.2009'
--and enter_time > TO_DATE('13012009105000','DDMMYYYYHHMISS')
group by process_status

update master_transactions
set process_status='WAITING'
where request_id='HFA 09.03.2009'
--and enter_time > TO_DATE('13012009105000','DDMMYYYYHHMISS')
--and enter_time>sysdate - 1
and process_status='IN_PROGRESS'

select * from master_transactions
where process_time between '24-Dec-2008' and '25-Dec-2008'
and subscriber_no='GSM04746615288'

select * from master_transactions where soc like 'CUG%' and action_code='MODIFY' and process_status='PRSD_SUCCESS'

UPDATE ninjadata.master_transactions a
SET a.process_status = 'WAITING'
WHERE a.request_id IN ('STLI 08.12.2010')
AND a.process_status = 'IN_PROGRESS'

UPDATE ninjadata.master_transactions a
set priority = 5 where process_status='WAITING'

select request_id, priority, count(*)
from master_transactions
where process_status='WAITING'
group by request_id, priority

update master_transactions
set process_Status='WAITING',status_desc=null
where status_desc like '%has been changed since last retrieved%'
and process_Status='PRSD_ERROR'
and request_id IN ('STLI 08.12.2010');
commit;

select * from master_transactions
where request_id='STLI15 2012-11-07'
and  process_status='PRSD_SUCCESS'

update master_transactions
set request_time=TO_DATE('2012-11-07 21:10', 'YYYY-MM-DD HH24:MI'), status_desc = null, process_status='WAITING'
where request_id='STLI15 2012-11-07' AND STATUS_DESC LIKE '%InvalidCombinationsException: Found 1 missing soc%'
and process_status='PRSD_ERROR'

update master_transactions
set priority=5
where request_id='STLI15 2012-11-07'
and process_status='WAITING'
and soc = 'MMS03'

update master_transactions
set stream = 1 
where request_id='STLI15'
and process_status='WAITING'
and stream = 7

UPDATE ninjadata.master_transactions a
  SET a.request_time = TO_DATE('2013-04-09 21:10', 'YYYY-MM-DD HH24:MI')
  WHERE a.request_id IN ('STLI15')
    AND a.process_status = 'WAITING'
