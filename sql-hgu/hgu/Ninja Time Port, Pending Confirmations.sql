/*
** List pending NP confirmations.
*/
SELECT a.ctn, a.ban, a.donor_code, o.operator_desc AS "DONOR_DESC",
       a.date_time_created, a.date_time_modified, a.date_time_port,
       a.action, a.proc_attempts, a.description
  FROM ninja_time_port a, np_operator_codes@fokus o
 WHERE a.status     = 'WAITING'
   AND a.action     = 'CONF'
   AND a.donor_code = RTRIM(o.np_operator_cd(+))
   AND a.date_time_created  BETWEEN o.effective_date AND NVL(o.expiration_date, SYSDATE + 1)
ORDER BY a.ninja_ref_id
;

/*
** List pending confirmations where the estimated DATE_TIME_PORT has passed.
*/
SELECT a.ctn, a.ban, a.donor_code, o.operator_desc AS "DONOR_DESC",
       a.date_time_created, a.date_time_modified, a.date_time_port,
       TRUNC(SYSDATE) - TRUNC(a.date_time_port) AS "OVERDUE_DAYS",
       a.action, a.proc_attempts, a.description
  FROM ninja_time_port a, np_operator_codes@fokus o
 WHERE a.status             = 'WAITING'
   AND a.action             = 'CONF'
   AND a.donor_code         = RTRIM(o.np_operator_cd(+))
   AND a.date_time_created  BETWEEN o.effective_date AND NVL(o.expiration_date, SYSDATE + 1)
   AND a.date_time_modified > a.date_time_port
ORDER BY a.ninja_ref_id
;

/*
** Attempt to list pending moves achieved via confirmations.
*/
SELECT a.ctn, a.ban, a.donor_code, o.operator_desc AS "DONOR_DESC",
       a.date_time_created, a.date_time_modified, a.date_time_port,
       a.action, a.proc_attempts, a.description
  FROM ninja_time_port a, np_operator_codes@fokus o
 WHERE a.status             = 'WAITING'
   AND a.action             = 'MOVE'
   AND a.donor_code         = RTRIM(o.np_operator_cd(+))
   AND a.date_time_created  BETWEEN o.effective_date AND NVL(o.expiration_date, SYSDATE + 1)
   AND a.description        = 'Date confirmed'
ORDER BY a.ninja_ref_id
;

/*
** List ALL pending moves
*/
SELECT a.ctn, a.ban, a.donor_code, o.operator_desc AS "DONOR_DESC",
       a.date_time_created, a.date_time_modified, a.date_time_port,
       a.action, a.proc_attempts, a.description
  FROM ninja_time_port a, np_operator_codes@fokus o
 WHERE a.status             = 'WAITING'
   AND a.action             = 'MOVE'
   AND a.donor_code         = RTRIM(o.np_operator_cd(+))
   AND a.date_time_created  BETWEEN o.effective_date AND NVL(o.expiration_date, SYSDATE + 1)
--   AND a.description        = 'Date confirmed'
ORDER BY a.ninja_ref_id
;

/*
** List ALL pending moves with operator and current status
*/
SELECT a.ctn, a.ban, a.donor_code, o1.operator_desc AS "DONOR_DESC",
       a.recipient_code, o2.operator_desc AS "RECIPIENT_DESC",
       a.date_time_created, a.date_time_modified, a.date_time_port,
       a.action, a.proc_attempts, a.description, s.sub_status
  FROM ninja_time_port a, np_operator_codes@fokus o1, np_operator_codes@fokus o2, subscriber@fokus s
 WHERE a.status             = 'WAITING'
   AND a.action             IN ( 'CONF', 'MOVE' )
   AND a.donor_code         = RTRIM(o1.np_operator_cd(+))
   AND a.date_time_created  BETWEEN o1.effective_date AND NVL(o1.expiration_date, SYSDATE + 1)
   AND a.recipient_code     = RTRIM(o2.np_operator_cd(+))
   AND a.date_time_created  BETWEEN o2.effective_date AND NVL(o2.expiration_date, SYSDATE + 1)
   AND 'GSM' || a.ctn       = s.subscriber_no(+)
   AND NVL(s.sys_update_date, SYSDATE) = (SELECT MAX(NVL(b.sys_update_date, SYSDATE)) FROM subscriber b WHERE b.subscriber_no = s.subscriber_no)
ORDER BY a.ninja_ref_id
;

/*
** List WEIRD pending moves
*/
SELECT a.ctn, a.ban, a.donor_code, o1.operator_desc AS "DONOR_DESC",
       a.recipient_code, o2.operator_desc AS "RECIPIENT_DESC",
       a.date_time_created, a.date_time_modified, a.date_time_port,
       a.action, a.proc_attempts, a.description
  FROM ninja_time_port a, np_operator_codes@fokus o1, np_operator_codes@fokus o2
 WHERE a.status             = 'WAITING'
   AND a.action             = 'MOVE'
   AND a.donor_code         = RTRIM(o1.np_operator_cd(+))
   AND a.date_time_created BETWEEN o1.effective_date AND NVL(o1.expiration_date, SYSDATE + 1)
   AND a.recipient_code     = RTRIM(o2.np_operator_cd(+))
   AND a.date_time_created BETWEEN o2.effective_date AND NVL(o2.expiration_date, SYSDATE + 1)
   AND a.date_time_port     > a.date_time_created + 365
ORDER BY a.ninja_ref_id
;
/*
** List WEIRD pending moves
*/
SELECT a.ctn, a.ban, a.donor_code, o1.operator_desc AS "DONOR_DESC",
       a.recipient_code, o2.operator_desc AS "RECIPIENT_DESC",
       a.date_time_created, a.date_time_modified, a.date_time_port,
       a.action, a.proc_attempts, a.description, s.sub_status
  FROM ninja_time_port a, np_operator_codes@fokus o1, np_operator_codes@fokus o2, subscriber@fokus s
 WHERE a.status             = 'WAITING'
   AND a.action             = 'MOVE'
   AND a.donor_code         = RTRIM(o1.np_operator_cd(+))
   AND a.date_time_created BETWEEN o1.effective_date AND NVL(o1.expiration_date, SYSDATE + 1)
   AND a.recipient_code     = RTRIM(o2.np_operator_cd(+))
   AND a.date_time_created BETWEEN o2.effective_date AND NVL(o2.expiration_date, SYSDATE + 1)
   AND a.date_time_port     > a.date_time_created + 365
   AND 'GSM'||a.ctn         = s.subscriber_no(+)
   AND s.sub_status_date   = (SELECT MAX(b.sub_status_date) FROM subscriber b WHERE b.subscriber_no = s.subscriber_no)
--   AND s.sub_status         = 'A'
ORDER BY a.ninja_ref_id
;


/*
** List porting operations in Fokus.
*/
SELECT tp.*, td.*
  FROM ninja_time_port tp, NP_TRX_DETAIL@fokus td
 WHERE tp.status      = 'WAITING'
   AND tp.action      = 'CONF'
   AND tp.ctn         = td.primary_num
   AND tp.date_time_port BETWEEN TRUNC(td.request_exec_date - 3) AND TRUNC(td.request_exec_date + 3)
   AND ROWNUM   < 101
;

/*
NTCAPPO NP_COMPANY_NUMBERS 
NTCAPPO NP_FORMATTED_DATA  
NTCAPPO NP_INT_TRANSACTIONS
NTCAPPO NP_NUMBER_INFO     
NTCAPPO NP_ORDER_DATA      
NTCAPPO NP_TRX_DETAIL      
NTCAPPO NP_TRX_ERRORS      
NTCAPPO NP_TRX_SERIES      
*/

SELECT ni.*
  FROM np_number_info@fokus ni
 WHERE rownum  < 11
;

SELECT ni.*
  FROM NP_ORDER_DATA@fokus ni
 WHERE rownum  < 11
;

SELECT td.*
  FROM NP_TRX_DETAIL@fokus td
 WHERE rownum  < 11
;

SELECT td.*
  FROM NP_TRX_SERIES@fokus td
 WHERE rownum  < 11
;
