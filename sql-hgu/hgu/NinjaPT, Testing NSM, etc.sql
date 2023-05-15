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
 where a.request_user_id like 'NINJA 2019-10%'
;
*/
update party_mgr_pid_update a
   set a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
 where a.request_id     = 3154
;

commit work
;
/*
SELECT /*+ driving_site(sii)*/
       sii.serial_number, sii.act_issue_date, sii.puk, sii.puk2
     , sii.initial_pin, sii.initial_pin2, sii.imsi, sii.hlr_cd
     , st.pki_ind, st.sim_type_desc
  FROM serial_item_inv@fokus sii, sim_type@fokus st
 WHERE sii.serial_number = '08947080041000004805'
   and sii.sim_type      = st.sim_type_id
;

select /*+ driving_site(a)*/ a.*
  from sim_type@fokus a
 where a.sim_type_id = '509'
;
*/