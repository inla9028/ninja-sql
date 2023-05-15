/*
select a.request_user_id, a.process_status, count(1) as "COUNT"
  from party_mgr_pid_update a
 where a.request_time > TRUNC(SYSDATE - 14)
group by a.request_user_id, a.process_status
order by a.request_user_id, a.process_status;

select a.*
  from party_mgr_pid_update a
 where a.request_time > TRUNC(SYSDATE - 7)
order by 1
;

update party_mgr_pid_update a
   set a.process_status = 'ON_HOLD'
 where a.request_user_id like 'NINJA 2019%'
;
*/
update party_mgr_pid_update a
   set a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
 where a.request_id     = 83
;

commit work
;
