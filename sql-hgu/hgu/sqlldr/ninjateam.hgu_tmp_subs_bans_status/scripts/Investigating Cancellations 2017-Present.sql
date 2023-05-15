SELECT a.ban, a.acc_type, a.acc_sub_type, a.subscriber_no, a.sub_status,
       a.dealer_code, a.date_time_port, a.sub_status_date
  FROM hgu_tmp_subs_bans_status a
;

/*
DELETE
  FROM hgu_tmp_subs_bans_status
;
*/

SELECT a.acc_type, a.acc_sub_type, a.sub_status, NVL(a.dealer_code, 'N/A') AS "DEALER_CODE", count(1) AS "COUNT"
  FROM hgu_tmp_subs_bans_status a
GROUP BY a.acc_type, a.acc_sub_type, a.sub_status, NVL(a.dealer_code, 'N/A')
ORDER BY 1,2,3
;

SELECT a.acc_type, a.acc_sub_type, t.description,
       a.sub_status, NVL(a.dealer_code, 'N/A') AS "DEALER_CODE", count(1) AS "COUNT"
  FROM hgu_tmp_subs_bans_status a, account_type@fokus t
 WHERE a.sub_status     = 'A'
   AND a.acc_type       = t.acc_type
   AND a.acc_sub_type   = t.acc_sub_type
   AND a.date_time_port > a.sub_status_date
GROUP BY a.acc_type, a.acc_sub_type, t.description, a.sub_status, NVL(a.dealer_code, 'N/A')
ORDER BY 1,2,3
;


SELECT a.*
  FROM hgu_tmp_subs_bans_status a
 WHERE a.sub_status IS NULL
;

SELECT a.*, b.*
  FROM hgu_tmp_subs_bans_status a, billing_account@fokus b
 WHERE a.sub_status IS NULL
   AND a.ban = b.ban
ORDER BY 3,1,2,4,5
;

SELECT a.*, s.sub_status, b.*
  FROM hgu_tmp_subs_bans_status a, billing_account@fokus b, subscriber@fokus s
 WHERE a.sub_status IS NULL
   AND a.subscriber_no = s.subscriber_no
   AND s.customer_id   = b.ban
ORDER BY 3,1,2,4,5
;

SELECT a.*, b.*
  FROM hgu_tmp_subs_bans_status a, ninjadata.ninja_time_port b
 WHERE a.sub_status IS NULL
   AND a.subscriber_no = 'GSM'||b.ctn
ORDER BY 3,1,2,4,5
;


