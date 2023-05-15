UPDATE ninjateam.hgu_tmp_subs_bans_status t2
   SET t2.ban          = (SELECT b.ban              FROM billing_account@fokus b, subscriber@fokus s WHERE s.subscriber_no IN (t2.subscriber_no) AND s.customer_id = b.ban AND s.sub_status NOT IN ('C'))
     , t2.acc_type     = (SELECT b.account_type     FROM billing_account@fokus b, subscriber@fokus s WHERE s.subscriber_no IN (t2.subscriber_no) AND s.customer_id = b.ban AND s.sub_status NOT IN ('C'))
     , t2.acc_sub_type = (SELECT b.account_sub_type FROM billing_account@fokus b, subscriber@fokus s WHERE s.subscriber_no IN (t2.subscriber_no) AND s.customer_id = b.ban AND s.sub_status NOT IN ('C'))
;

-- Update status
UPDATE ninjateam.hgu_tmp_subs_bans_status t2
   SET t2.sub_status = (SELECT s.sub_status FROM subscriber@fokus s WHERE t2.ban IS NOT NULL AND s.customer_id = t2.ban AND s.subscriber_no = t2.subscriber_no)
;

-- Update dealer and sales agent...
UPDATE ninjateam.hgu_tmp_subs_bans_status t2
   SET t2.dealer_code = (SELECT s.dealer_code FROM subscriber@fokus s WHERE t2.ban IS NOT NULL AND s.customer_id = t2.ban AND s.subscriber_no = t2.subscriber_no)
;

SELECT t2.subscriber_no, s.sub_status, s.sub_status_date, b.ban, b.account_type, b.account_sub_type
  FROM ninjateam.hgu_tmp_subs_bans_status t2, subscriber@fokus s, billing_account@fokus b
 WHERE t2.subscriber_no = s.subscriber_no
   AND s.customer_id    = b.ban
--   AND b.ban_status     = 'O'
   AND s.sub_status_date > TO_DATE('2017-10-01','YYYY-MM-DD')
   AND b.account_type   = 'H'
   AND b.account_sub_type = 'PC'
ORDER BY t2.subscriber_no, s.sub_status ASC
;

SELECT SUBSCRIBER_NO, COUNT(1) AS "COUNT"
FROM (
SELECT t2.subscriber_no, s.sub_status, s.sub_status_date, b.ban, b.account_type, b.account_sub_type
  FROM ninjateam.hgu_tmp_subs_bans_status t2, subscriber@fokus s, billing_account@fokus b
 WHERE t2.subscriber_no = s.subscriber_no
   AND s.customer_id    = b.ban
--   AND b.ban_status     = 'O'
   AND s.sub_status_date > TO_DATE('2017-10-01','YYYY-MM-DD')
   AND b.account_type   = 'H'
   AND b.account_sub_type = 'PC'
ORDER BY t2.subscriber_no, s.sub_status ASC
)
GROUP BY subscriber_no
ORDER BY 2 DESC, 1
;


SELECT t2.subscriber_no, s.sub_status, s.sub_status_date, b.ban, b.account_type, b.account_sub_type
  FROM ninjateam.hgu_tmp_subs_bans_status t2, subscriber@fokus s, billing_account@fokus b
 WHERE t2.subscriber_no IN ('GSM04741000249','GSM04741360270','GSM04746415234','GSM04748099146','GSM04748603771','GSM04791772787','GSM04793430545','GSM04798491800')
   AND t2.subscriber_no = s.subscriber_no
   AND s.customer_id    = b.ban
--   AND b.ban_status     = 'O'
   AND s.sub_status_date > TO_DATE('2017-10-01','YYYY-MM-DD')
ORDER BY 1,3
;

-- 'GSM04745066314','GSM04795180380','SM04798296576','GSM04799155274'
