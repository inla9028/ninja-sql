SELECT COUNT(1) as "ROW_COUNT"
  FROM dsp_request
 WHERE process_status       = 'WAITING'
   --AND record_creation_date > SYSDATE
;

select a.*
  from dsp_request a
;

update dsp_request a
   set a.process_status = 'ON_HOLD'
 where process_status   = 'WAITING'
;

update dsp_request a
   set a.process_status = 'WAITING'
 where process_status   = 'ON_HOLD'
;

update dsp_request a
   set a.process_status = 'PRSD_SUCCESS', a.process_time = SYSDATE
 where process_status   = 'WAITING'
;