 
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all (or failed) records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.new_priceplan, a.new_campaign_code,
       a.new_subscription_type, a.handle_commitment, a.effective_date,
       a.dealer, a.sales_agent, a.reason_code, a.memo_text,
       a.waive_fees, a.enter_time, a.request_time, a.process_time,
       a.process_status, a.status_desc, a.priority, a.requestor_id,
       a.skip_ninja_validation
  FROM master_chg_pp_trans a
  WHERE a.requestor_id     IN ('OBM')
--    AND a.enter_time     > TRUNC(SYSDATE)
and rownum < 10
    AND a.process_status = 'PRSD_ERROR'
    --and subscriber_no = ''
order by a.status_desc       

select process_status, count(*)
FROM ninjadata.master_chg_pp_trans a
  WHERE requestor_id     IN ('TRU 16.07.2014')
  group by process_status

update master_chg_pp_trans
set process_status='WAITING'
WHERE requestor_id     IN ('TRU 16.07.2014')
and process_status='IN_PROGRESS'

select requestor_id, process_status, min(process_time), max(process_time), count(*),

decode(process_status , 'PRSD_SUCCESS', round((max(process_time) - min(process_time)) * 24 * 60, 2), null) as mins_so_far, 

decode(process_status , 'PRSD_SUCCESS', round(count(*) / ((max(process_time) - min(process_time)) * 24 * 60), 2), null) as rows_per_min

from master_chg_pp_trans a

where requestor_id = 'STLI15 19.07.2010'

--and process_time > sysdate - 1/48 -- Up to 11.5/min now. 1/24 = last hour, 1/48 = 30 mins, 1/60 = 20 mins, 1/90 ~ 16 mins, 1/120 = 10 mins

group by requestor_id, process_status

order by requestor_id, process_status

;

select priority, count(*) from master_chg_pp_trans
where process_status='WAITING'
group by priority

select * from master_chg_pp_trans
where process_status='WAITING'

select * from master_chg_pp_trans
where subscriber_no='CDA04721023700'

select * from master_chg_pp_trans
where requestor_id = 'STLI15 19.07.2010'
order by process_time

SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_chg_pp_trans a
  WHERE requestor_id = 'AWG'
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY  a.status_desc
  
  select * from master_chg_pp_trans
  where enter_time > sysdate - 6
  
  update master_chg_pp_trans
  set handle_commitment='N', process_Status='WAITING' where process_status='PRSD_ERROR'
  and a.requestor_id     IN ('OBM')
  
  update master_chg_pp_trans
  set skip_ninja_validation='Y', process_Status='WAITING' 
  where process_status='PRSD_ERROR'
  and requestor_id     IN ('OBM')
  
  
  
  update master_chg_pp_trans
  set reason_code='BYT5', process_Status='WAITING' 
  where requestor_id     IN ('DEI 22.09.2005')
  and process_Status='PRSD_ERROR'
  
/*
** Distribute records onto 10 streams instead of just one...
*/
UPDATE master_chg_pp_trans a
   SET a.stream = MOD(ROWNUM, 10) + 1 -- Displays even 1-10
   --SET a.stream = MOD(ROWNUM, 9) + 2 -- Displays even 2-10, leaving stream 1 free
 WHERE a.requestor_id   IN ( 'TRU 16.07.2014' )
   AND a.process_status IN ( 'WAITING', 'IN_PROGRESS', 'ON_HOLD' )
   AND a.stream          = '1'
;


/*
** Display the remaining (aka WAITING) records per stream.
*/
SELECT a.requestor_id, a.stream, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.748) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.748) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM master_chg_pp_trans a
 WHERE a.requestor_id IN ('TRU 16.07.2014')
   AND a.process_status = 'WAITING'
GROUP BY a.requestor_id, a.stream, a.process_status
ORDER BY a.requestor_id, TO_NUMBER(a.stream), a.process_status
;
