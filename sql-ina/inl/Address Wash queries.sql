-- check the log
SELECT a.log_seq_no, a.created_date, a.shell_file_name, a.package_name,
       a.procedure_name, a.step_no, a.line_number, a.ora_error_code,
       a.ora_error_msg, a.message, a.log_type_id, a.run_id,
       a.message_distributed_date, a.mail_id, a.error_cleared_date
FROM cdw_process_log a
where created_date > sysdate - 9
--and package_name !='SEND_MAIL'
order by log_seq_no desc

---------------------------------------------
---------Post Wash job queries --------------
---------------------------------------------
  
-- check if post process job finished
SELECT *
FROM cdw_process_log 
where package_name = 'CDW_POSTWASH' 
and     procedure_name = 'CDW_UPD_CUST_AND_LOC_TABLES'
and   step_no = 2000
order by log_seq_no desc

-- get number of records in the file
select count(*) from cdw_postprocess
where file_name = 'DMH_BEDRIFT_20141005195.txt'

select * from cdw_postprocess
where file_name = 'DMH_PRIVAT_20141102196.txt'
and DM_RECOMMENDATION_CODE = 'M'
--and cdw_wash_status='IN MANUAL'


-- get number of processed records by their status
-- 'S' - will be updated in Fokus after Fokus job CSUPNMADR runs
-- 'M' - sent for manual handling and manul file(s) should come back for processing
select dm_recommendation_code, count(*) from cdw_postprocess
where file_name = 'DMH_BEDRIFT_20141102197.txt'
group by dm_recommendation_code

select * from cdw_postprocess
where file_name = 'DMH_BEDRIFT_20141102197.txt'
and nc_ban=519192116
  
-- get all possible record types, received from DM Huset by dm_status
select dm_status, count(*) from cdw_postprocess
--where file_name = 'DMH_PRIVAT_20111201135.txt'
where file_number=135
group by dm_status
  
select count(*)
from cdw_postprocess
where file_number=135
and dm_status='S'
and ( nvl(dm_addresscode,0) in (1,2,3,4,5,6,7,8,9)
or nvl(dm_condition_status,0) in (2,3,4,5,6,7,8,9))


  
-- select all records that have to go to manaul handling.
select count(*) from cdw_manual_files_org
where file_number=196

-- select number of records in each manual file according to received file number
select file_name, count(*)
from cdw_manual_files_org
where file_number=195
group by file_name

-- select number of records for each dm_status according to received file number
select dm_status, count(*)
from cdw_manual_files_org
where file_number=135
group by dm_status

-- select number of records for each dm_recommendation_code according to received file number
select dm_recommendation_code, count(*) 
from cdw_manual_files_org
where file_number=135
group by dm_recommendation_code

-- records with dm_status 'S' can also go to manual handling according to received file number 
select * from cdw_manual_files_org
where file_number=135
and dm_status='S'
and rownum < 100

--check how many records waiting to be processed by Fokus job
select count(*)
from ntcappc_lng5.customer_washed_data
where trx_status='N'

-- select records from Fokus by status
select trx_status, count(*)
from ntcappc_lng5.customer_washed_data
where trx_sts_date > sysdate -1
group by trx_status

--------------------------------------------------
---------- Manual file receive queries ----------
--------------------------------------------------

select dm_status, dm_recommendation_code, count(*) from CDW_MANUAL_FILES_EDITED
where cdw_man_edited_file='cdw_manual_org_201112031401.dat'
group by dm_status, dm_recommendation_code

select cdw_man_edited_action, count(*) 
from CDW_MANUAL_FILES_EDITED
where cdw_man_edited_file='cdw_manual_org_201112031402.dat'
group by cdw_man_edited_action 

select *
from CDW_MANUAL_FILES_EDITED
where cdw_man_edited_file='cdw_manual_org_201112031401.dat'

-- check how many records should be updated in Fokus and then check how many are waiting in Fokus to be processed
select count(*) from cdw_fokus_update fu
where file_name = 'DMH_PRIVAT_20111201135.txt' --original file name name received by the post wash process
and file_number = 135
and cdw_wash_status_rsn is null
and cdw_wash_status_date like '%-DEC-11' --date from the input file
and exists (select 1 from CDW_MANUAL_FILES_EDITED m
where m.cdw_received_id = fu.cdw_received_id
--and cdw_man_edited_file='cdw_manual_org_201112031405.dat') -- manual file name, returned from manual handling
and cdw_man_edited_file like 'cdw_manual_org_201112031%')

--check how many records waiting to be processed by Fokus job. Should be same number as in the above query
select count(*)
from ntcappc_lng5.customer_washed_data
where trx_status='N'

-- check if there are any records with wrong birth date
select *
from customer_washed_data c2
where c2.trx_sts_date > to_date('01-03-2012','dd.mm.yyyy')
and c2.trx_status != 'N' and
c2.birth_date < '01-JAN-1900';

-- select emails requests
SELECT a.mail_id, a.created_date, a.status, a.status_date, a.recipient,
       a.title, a.mail_body, a.test, a.ref_number, a.ref_source
  FROM cdw_mail_send a
  where created_date > sysdate-1
  order by mail_id desc
  
------------------------------------
------- Oracle cron jobs -----------
------------------------------------

-- check Oracle cron tab jobs
select * from all_jobs

-- marks job 152 as not broken and sets its next execution date to the following Monday
exec dbms_job.broken(152, FALSE, NEXT_DAY(SYSDATE, 'Mandag')); 
exec dbms_job.broken(151, FALSE);

--Reset next execution date and time for a job 
exec dbms_job.next_date(152, SYSDATE);  

--stop cron job
exec dbms_job.broken(152,TRUE);

select nc_ban,nc_subscriber_no,nc_link_type,nc_birth_date,dm_birth_date from cdw_postprocess c1, customer_washed_data c2
where file_name = 'DMH_PRIVAT_20111201135.txt' and batch_id=5681 and file_number=135
and c1.nc_ban = c2.customer_id and c1.nc_subscriber_no=c2.subscriber_no and c1.nc_link_type=c2.link_type
and c2.trx_sts_date > to_date('01-12-2011','dd.mm.yyyy')
and c2.trx_status = 'S'

-- check ACL for email sending
--COLUMN acl FORMAT A30
--COLUMN principal FORMAT A30

SELECT acl,principal,privilege,is_grant, TO_CHAR(start_date, 'DD-MON-YYYY') AS start_date, TO_CHAR(end_date, 'DD-MON-YYYY') AS end_date
FROM   dba_network_acl_privileges;

--Fokus rollback
select * from cdw_rollback_fokus order by created_date desc

insert into cdw_rollback_fokus (select nc_ban, nc_subscriber_no, nc_link_type,'T',cdw_cust_washed_data_id,sysdate 
from cdw_fokus_update fu
where file_name in ('DMH_PRIVAT_20120520144.txt', 'DMH_BEDRIFT_20120520145.txt') and cdw_cust_washed_data_id is not null)

update cdw_rollback_fokus set status='T' where status='N'

select count(*) from cdw_fokus_update fu
where file_name in ('DMH_PRIVAT_20120520144.txt','DMH_BEDRIFT_20120520145.txt') 
and cdw_cust_washed_data_id is not null


delete cdw_rollback_fokus where status='T'

select * from ntcappc_lng5.customer_washed_data
where customer_id=736048802 and subscriber_no='GSM04792024768'

select count (*) from ntcappc_lng5.customer_washed_data
where trunc(trx_sts_date) >= '22-MAI-2012'
and trx_status='S'

select * from cdw_fokus_update fu
where file_name = 'DMH_PRIVAT_20120520144.txt' 
and cdw_cust_washed_data_id is not null
and not exists (select 1 from ntcappc_lng5.customer_washed_data
where trunc(trx_sts_date) >= '22-MAI-2012' and washed_data_id=cdw_cust_washed_data_id)

select * from ntcappc_lng5.customer_washed_data
where washed_data_id=49394178

select * from ntcappc_lng5.customer_washed_data
where trx_status='N'

select * from ntcappc_lng5.address_name_link
where ban=809956600 and subscriber_no='GSM04792086929'
