/*
** List SMSes sent due to IVER.
*/
select a.*
  from batch_np_activities a
 where a.activity_code = 'IVERSM'
   and a.action        = 'S'
   and a.record_creation_date > trunc(sysdate)
   and rownum < 11
;

/*
** List subscribers from the Tele2 migration, who has received IVERSMS via Ninja
*/
select f.ban, f.subscriber_no, a.activity_code, a.action, a.process_time
  from batch_np_activities a, api_master_transactions@fokus f
 where a.activity_code        = 'IVERSM'
   and a.action               = 'S'
   and a.port_number          = f.subscriber_no
   and f.request_status       = 'S'
--   and a.record_creation_date between to_date('2015-05-01', 'YYYY-MM-DD') and  to_date('2015-06-01', 'YYYY-MM-DD')
   and a.record_creation_date > trunc(sysdate)
   and rownum                 < 11
;

/*
** List the number of activated SIM numbers for the Tele2 migration.
*/
select f.ban, f.subscriber_no, p.equipment_no, p.effective_date, p.expiration_date
  from api_master_transactions@fokus f, physical_device@fokus p
 where f.request_status       = 'S'
   and rownum                 < 11
   and f.ban                  = p.customer_id
   and p.subscriber_no        = 'GSM' || f.subscriber_no
   and p.device_type          = 'E' 
;

/*
** A synynom to the table in Fokus (ntcappc_lng5) that loads the Tele2 migration.
*/
select a.*
  from api_master_transactions@fokus a
 where 1 = 1
   and rownum < 11
;

select a.*
  from ninja_time_port a
 where a.date_time_port > trunc(sysdate)
;

select a.action, a.ninja_action, count(1) as "COUNT"
  from ninja_time_port a
 where a.date_time_port    > trunc(sysdate)
   and a.date_time_created > trunc(sysdate)
group by a.action, a.ninja_action
order by a.action, a.ninja_action
;

select s.*
  from physical_device@fokus s
 where rownum < 11
;
 

SELECT *
  FROM NINJA_NP_ACTIVITY
ORDER BY ACTIVITY_CODE
;

select a.*
  from ninja_time_port a
 where a.date_time_port > trunc(sysdate)
;

--
/*
** List IVER SMSes per day.
*/
select to_char(a.process_time, 'YYYY-MM-DD') as "PROCESS_TIME", a.activity_code
      , a.action, count(1) as "COUNT"
  from batch_np_activities a, api_master_transactions@fokus f
 where a.activity_code        = 'IVERSM'
   and a.action               = 'S'
   and a.port_number          = f.subscriber_no
   and f.request_status       = 'S'
--   and a.record_creation_date between to_date('2015-05-01', 'YYYY-MM-DD') and  to_date('2015-06-01', 'YYYY-MM-DD')
--   and a.record_creation_date > trunc(sysdate)
   and a.record_creation_date > to_date('2015-04-01', 'YYYY-MM-DD')
group by to_char(a.process_time, 'YYYY-MM-DD'), a.activity_code, a.action
order by to_char(a.process_time, 'YYYY-MM-DD'), a.activity_code, a.action
;

/*
** List nr of SIMs per day.
*/
select to_char(p.effective_date, 'YYYY-MM-DD') as "SIM_EFFECTIVE_DATE"
     , count(1) as "COUNT"
  from api_master_transactions@fokus f, physical_device@fokus p
 where f.request_status       = 'S'
   and f.ban                  = p.customer_id
   and p.subscriber_no        = 'GSM' || f.subscriber_no
   and p.device_type          = 'E'
   and sysdate between p.effective_date and nvl(p.expiration_date, sysdate + 1)
group by to_char(p.effective_date, 'YYYY-MM-DD')
order by to_char(p.effective_date, 'YYYY-MM-DD')
;

/*
** List deactivated SIMs per day.
*/
select to_char(p.effective_date, 'YYYY-MM-DD') as "SIM_EFFECTIVE_DATE"
     , TO_CHAR(to_NUMBER(p.expiration_date - p.effective_date), '9999999.9') as "DAYS"
     , count(1) as "COUNT"
  from api_master_transactions@fokus f, physical_device@fokus p
 where f.request_status       = 'S'
   and f.ban                  = p.customer_id
   and p.subscriber_no        = 'GSM' || f.subscriber_no
   and p.device_type          = 'E'
   and sysdate                > nvl(p.expiration_date, sysdate + 1)
group by to_char(p.effective_date, 'YYYY-MM-DD'), TO_CHAR(to_NUMBER(p.expiration_date - p.effective_date), '9999999.9')
order by to_char(p.effective_date, 'YYYY-MM-DD'), TO_CHAR(to_NUMBER(p.expiration_date - p.effective_date), '9999999.9')
;